import requests

class AbuseIPDBTool:
    def __init__(self, api_key):
        self.api_key = api_key

    def scan_ip(self, ip):
        url = "https://api.abuseipdb.com/api/v2/check"
        headers = {
            "Key": self.api_key,
            "Accept": "application/json"
        }
        params = {
            "ipAddress": ip,
            "maxAgeInDays": 90
        }
        response = requests.get(url, headers=headers, params=params)
        if response.status_code == 200:
            data = response.json()
            return {
                "abuseConfidenceScore": data["data"]["abuseConfidenceScore"],
                "totalReports": data["data"]["totalReports"]
            }
        return {"error": "AbuseIPDB failed"}
