class SelfTestAgent:
    def __init__(self):
        self.required_fields = {
            "threatintel_agent": ["virustotal", "abuseipdb", "ipinfo"],
            "osint_agent": ["hibp", "hunter"],
            "correlation_agent": ["analysis"],
            "rag_agent": ["llm_summary"],
            "report_agent": ["file"]
        }

    def handle_task(self, payload):
        agent_name = payload.get("agent_name")
        result = payload.get("result")

        issues = []

        # Field Check
        expected = self.required_fields.get(agent_name, [])
        for field in expected:
            if field not in result:
                issues.append(f"Missing field: {field}")
            elif not result[field]:
                issues.append(f"Empty field: {field}")

        # Threat-specific Check
        if agent_name == "threatintel_agent":
            try:
                abuse_score = int(result["abuseipdb"].get("abuseConfidenceScore", 0))
                vt_rep = int(result["virustotal"].get("reputation", 0))

                if abuse_score > 80 and vt_rep >= 0:
                    issues.append("Anomaly: High abuse score but VT rep not flagged")

            except Exception as e:
                issues.append(f"Error parsing fields: {e}")

        if not issues:
            return {"status": "PASSED", "message": "Agent output looks valid ✅"}

        return {
            "status": "FAILED",
            "issues": issues
        }
