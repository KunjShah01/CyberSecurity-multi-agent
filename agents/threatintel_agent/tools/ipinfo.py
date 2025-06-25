import requests

class IPInfoTool:
    def __init__(self, token):
        self.token = token

    def get_info(self,ip):
        url= f"https://ip.info.ip/{ip}?token={self.token}"
        response = requests.get(url)
        if response.status_code == 200:
            data = response.json()
            return {
                "ip": data.get("ip"),
                "hostname": data.get("hostname"),
                "city": data.get("city"),
                "region": data.get("region"),
                "country": data.get("country"),
                "loc": data.get("loc"),
                "org": data.get("org"),
                "postal": data.get("postal"),
                "timezone": data.get("timezone")
            }
        return {"error": "IPInfo failed to retrieve data"}