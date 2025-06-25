from datetime import datetime

class ReportAgent:
    def __init__(self, template_path="agents/report_agent/templates/report_template.md"):
        with open(template_path, "r") as f:
            self.template = f.read()

    def handle_task(self, payload):
        filled = self.template.format(
            ip=payload.get("ip", "N/A"),
            vt_rep=payload.get("virustotal", {}).get("reputation", "-"),
            abuse_score=payload.get("abuseipdb", {}).get("abuseConfidenceScore", "-"),
            geo=payload.get("ipinfo", {}).get("country", "-"),
            hibp_data=payload.get("osint", {}).get("hibp", "None"),
            hunter_data=payload.get("osint", {}).get("hunter", "None"),
            ai_analysis=payload.get("correlation", {}).get("analysis", "N/A"),
            timestamp=datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        )

        report_file = f"report_{payload.get('ip', 'unknown')}.md"
        with open(report_file, "w") as f:
            f.write(filled)

        return {"message": "Report generated", "file": report_file}
