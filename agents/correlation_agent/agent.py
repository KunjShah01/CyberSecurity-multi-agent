import google.generativeai as genai
import os

class CorrelationAgent:
    def __init__(self, gemini_api_key):
        os.environ["GOOGLE_API_KEY"] = gemini_api_key
        genai.configure(api_key=gemini_api_key)
        self.model = genai.GenerativeModel("gemini-pro")

        with open("agents/correlation_agent/prompt_templates/reasoning_prompt.txt", "r") as f:
            self.prompt_template = f.read()

    def handle_task(self, task_payload):
        threat_data = task_payload.get("threatintel", {})
        osint_data = task_payload.get("osint", {})

        full_prompt = self.prompt_template.format(
            threat_data=threat_data,
            osint_data=osint_data
        )

        response = self.model.generate_content(full_prompt)
        return {
            "analysis": response.text.strip()
        }
