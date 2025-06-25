from .tools.virustotal import VirusTotalTool
from .tools.abuseipdb import AbuseIPDBTool
from .tools.ipinfo import IPInfoTool
from db.logger import DBLogger

class ThreatIntelAgent:
    def __init__(self, vt_key, abuse_key, ipinfo_token):
        self.vt = VirusTotalTool(vt_key)
        self.abuse = AbuseIPDBTool(abuse_key)
        self.ipinfo = IPInfoTool(ipinfo_token)
        self.logger = DBLogger()

    def handle_task(self, ip):
        vt_data = self.vt.scan_ip(ip)
        abuse_data = self.abuse.scan_ip(ip)
        ipinfo_data = self.ipinfo.get_info(ip)

        self.logger.log_scan(ip, vt_data, abuse_data, ipinfo_data)

        return {
            "ip": ip,
            "virustotal": vt_data,
            "abuseipdb": abuse_data,
            "ipinfo": ipinfo_data
        }
