import requests

class VirusTotalTool:
    def __init__(self, api_key):
        self.api_key = api_key

    def scan_ip(self, ip):
        url = f"https://www.virustotal.com/api/v3/ip_addresses/{ip}"
        headers = {"x-apikey": self.api_key}
        response = requests.get(url, headers=headers)
        if response.status_code == 200:
            data = response.json()
            return {
                "reputation": data["data"]["attributes"]["reputation"],
                "last_analysis_stats": data["data"]["attributes"]["last_analysis_stats"]
            }
        return {"error": "VirusTotal failed"}
