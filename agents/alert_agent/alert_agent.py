import smtplib
from email.mime.text import MIMEText
import requests

class AlertAgent:
    def __init__(self, email_sender, email_pass, recipient, slack_webhook=None, discord_webhook=None):
        self.email_sender = email_sender
        self.email_pass = email_pass
        self.recipient = recipient
        self.slack_webhook = slack_webhook
        self.discord_webhook = discord_webhook

    def check_and_alert(self, result):
        abuse_score = result.get("abuseipdb", {}).get("abuseConfidenceScore", 0)
        vt_rep = result.get("virustotal", {}).get("reputation", 0)

        if int(abuse_score) > 50 or int(vt_rep) < 0:
            self.send_email_alert(result)
            self.send_slack_alert(result)
            self.send_discord_alert(result)

    def send_email_alert(self, result):
        msg = MIMEText(str(result))
        msg['Subject'] = '⚠️ Security Alert: Suspicious IP Detected'
        msg['From'] = self.email_sender
        msg['To'] = self.recipient
        try:
            with smtplib.SMTP_SSL('smtp.gmail.com', 465) as smtp:
                smtp.login(self.email_sender, self.email_pass)
                smtp.send_message(msg)
            print("[AlertAgent] Email sent.")
        except Exception as e:
            print(f"[AlertAgent] Email failed: {e}")

    def send_slack_alert(self, result):
        if self.slack_webhook:
            text = f":rotating_light: Suspicious IP Alert:\n```{str(result)}```"
            requests.post(self.slack_webhook, json={"text": text})

    def send_discord_alert(self, result):
        if self.discord_webhook:
            content = f"🚨 Suspicious IP Alert:\n```{str(result)}```"
            requests.post(self.discord_webhook, json={"content": content})
