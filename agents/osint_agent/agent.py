from .tools.haveibeenpwned import HaveIBeenPwnedTool
from .tools.hunterio import HunterIOTool

class OSINTAgent:
    def __init__(self, hibp_key, hunter_key):
        self.hibp_tool = HaveIBeenPwnedTool()
        self.hunter_tool = HunterIOTool(hunter_key)
        self.hibp_key = hibp_key

    def handle_task(self, query):
        result = {}
        if "@" in query:  # Email
            result["hibp"] = self.hibp_tool.check_email(query, self.hibp_key)
        elif "." in query:  # Domain
            result["hunter"] = self.hunter_tool.domain_search(query)
        else:
            result["error"] = "Input must be a domain or email"
        return result
