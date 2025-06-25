import requests

class HunterIOTool:
    def __init__(self, api_key):
        self.api_key = api_key

    def domain_search(self, domain):
        url = f"https://api.hunter.io/v2/domain-search?domain={domain}&api_key={self.api_key}"
        response = requests.get(url)
        if response.status_code == 200:
            data = response.json()
            return data.get("data", {}).get("emails", [])
        return {"error": "Hunter API error"}
