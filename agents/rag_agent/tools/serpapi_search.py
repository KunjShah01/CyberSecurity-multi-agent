import requests

class SerpAPISearch:
    def __init__(self, serpapi_key):
        self.api_key = serpapi_key

    def search(self, query):
        params = {
            "q": query,
            "api_key": self.api_key,
            "num": 5,
            "engine": "google"
        }
        res = requests.get("https://serpapi.com/search", params=params)
        results = res.json().get("organic_results", [])
        return [{
            "title": r.get("title"),
            "link": r.get("link"),
            "snippet": r.get("snippet")
        } for r in results]
