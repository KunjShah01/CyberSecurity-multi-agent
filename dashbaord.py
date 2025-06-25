import streamlit as st
from .controller_agent import ControllerAgent
from alert_agent.alert_agent import AlertAgent
from db.logger import DBLogger
import pandas as pd
import ast
SLACK_WEBHOOK = "https://hooks.slack.com/services/XXX/YYY/ZZZ"
DISCORD_WEBHOOK = "https://discord.com/api/webhooks/XXX/YYY"

# Email
EMAIL = "yourmail@gmail.com"
PASS = "yourpassword"
TO = "recipient@example.com"

alert_agent = AlertAgent(
    EMAIL, PASS, TO,
    slack_webhook=SLACK_WEBHOOK,
    discord_webhook=DISCORD_WEBHOOK
)
# API Keys
VT_KEY = "YOUR_VT_KEY"
ABUSE_KEY = "YOUR_ABUSEIPDB_KEY"
IPINFO_TOKEN = "YOUR_IPINFO_TOKEN"

# Instantiate
controller = ControllerAgent(VT_KEY, ABUSE_KEY, IPINFO_TOKEN)
alert_agent = AlertAgent(EMAIL, PASS, TO)
db = DBLogger()

st.set_page_config(layout="wide")
st.title("🛡️ Multi-AI Security Agent Dashboard")

ip = st.text_input("Enter IP Address")

if st.button("Run Full Scan"):
    result = controller.send_task(ip)
    alert_agent.check_and_alert(result)
    st.success("Scan complete!")
    st.subheader("🧠 Intelligence Report")
    st.json(result)

# History Table
st.subheader("📜 Scan History")
history = db.fetch_all()

if history:
    table_data = []
    for row in history:
        table_data.append({
            "IP": row[1],
            "VT": str(ast.literal_eval(row[2]).get("reputation", "-")),
            "AbuseScore": str(ast.literal_eval(row[3]).get("abuseConfidenceScore", "-")),
            "Geo": str(ast.literal_eval(row[4]).get("country", "-")),
            "Time": row[5]
        })
    df = pd.DataFrame(table_data)
    st.dataframe(df)
else:
    st.info("No scan history yet.")
