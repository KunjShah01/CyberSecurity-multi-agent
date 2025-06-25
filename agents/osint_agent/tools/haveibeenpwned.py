import requests

class HaveIBeenPwnedTool:
    def __init__(self):
        self.base_url = "https://haveibeenpwned.com/api/v3/breachedaccount/"

    def check_email(self, email, api_key):
        headers = {
            "hibp-api-key": api_key,
            "User-Agent": "SecurityMultiAgent-Kunj"
        }
        url = f"{self.base_url}{email}?truncateResponse=false"
        response = requests.get(url, headers=headers)
        if response.status_code == 200:
            return response.json()
        elif response.status_code == 404:
            return {"breached": False}
        else:
            return {"error": "API error or rate limit exceeded"}
