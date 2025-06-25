from agents.threatintel_agent import ThreatIntelAgent
from agents.osint_agent import OSINTAgent
from agents.correlation_agent import CorrelationAgent
from agents.rag_agent import RAGAgent
from agents.report_agent import ReportAgent
from agents.alert_agent import AlertAgent
from agents.selftest_agent import SelfTestAgent
from logger import log_to_db

class ControllerAgent:
    def __init__(self, **kwargs):
        self.agents = {
            "threatintel_agent": ThreatIntelAgent(**kwargs),
            "osint_agent": OSINTAgent(**kwargs),
            "correlation_agent": CorrelationAgent(),
            "rag_agent": RAGAgent(**kwargs),
            "report_agent": ReportAgent(),
            "alert_agent": AlertAgent(email_password=kwargs.get("email_pass")),
            "selftest_agent": SelfTestAgent()
        }

    def run(self, query: str, scan_id: str = None):
        results = {}

        threat_result = self.agents["threatintel_agent"].handle_task({"query": query})
        results["threatintel"] = threat_result

        osint_result = self.agents["osint_agent"].handle_task({"query": query})
        results["osint"] = osint_result

        correlation_result = self.agents["correlation_agent"].handle_task({
            "threatintel": threat_result, "osint": osint_result
        })
        results["correlation"] = correlation_result

        rag_result = self.agents["rag_agent"].handle_task({
            "query": query, "threat_data": threat_result
        })
        results["rag"] = rag_result

        report_result = self.agents["report_agent"].handle_task({
            "ip": query,
            "virustotal": threat_result.get("virustotal", {}),
            "abuseipdb": threat_result.get("abuseipdb", {}),
            "ipinfo": threat_result.get("ipinfo", {}),
            "osint": osint_result,
            "correlation": correlation_result
        })
        results["report"] = report_result

        test_result = self.agents["selftest_agent"].handle_task({
            "agent_name": "threatintel_agent",
            "result": threat_result
        })
        results["selftest"] = test_result

        alert_result = self.agents["alert_agent"].check_and_alert(threat_result)
        results["alert"] = alert_result

        if scan_id:
            log_to_db(scan_id, query, results)

        return results
