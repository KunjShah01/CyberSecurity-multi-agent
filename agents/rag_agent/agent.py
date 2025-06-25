import os
import google.generativeai as genai
from .tools.serpapi_search import SerpAPISearch

class RAGAgent:
    def __init__(self, serpapi_key, gemini_key):
        self.search_tool = SerpAPISearch(serpapi_key)
        os.environ["GOOGLE_API_KEY"] = gemini_key
        genai.configure(api_key=gemini_key)
        self.model = genai.GenerativeModel("gemini-pro")

    def handle_task(self, payload):
        query = payload.get("query", "")
        threat_data = payload.get("threat_data", {})

        web_results = self.search_tool.search(query)

        search_summary = "\n".join([
            f"- {r['title']} ({r['link']}): {r['snippet']}" for r in web_results
        ])

        full_prompt = f"""
You are a cybersecurity analyst. Use the threat intel data and real-time web search results below to summarize the situation.

## 🔍 Threat Intel:
{threat_data}

## 🌐 Web Search:
{search_summary}

Answer:
- Is this query related to a known threat?
- What can be inferred based on real-time information?
"""

        response = self.model.generate_content(full_prompt)
        return {
            "search_results": web_results,
            "llm_summary": response.text.strip()
        }
