import streamlit as st
import requests
import pandas as pd
import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'db')))
from db.logger import read_logs
import os

API_URL = "http://localhost:8000/scan"

st.set_page_config(page_title="🔐 Multi-AI Security Scanner", layout="wide")
st.title("🛡️ Security Multi-AI Agent Dashboard")

# === Sidebar ===
with st.sidebar:
    st.header("🔐 Credentials")
    serpapi_key = st.text_input("SerpAPI Key", type="password")
    gemini_key = st.text_input("Gemini Key", type="password")
    email_pass = st.text_input("Email Password (optional)", type="password")

    st.header("🔍 Scan")
    query = st.text_input("Enter IP / Email / Domain")
    if st.button("Run Scan"):
        with st.spinner("Running agents..."):
            res = requests.post(API_URL, json={
                "query": query,
                "serpapi_key": serpapi_key,
                "gemini_key": gemini_key,
                "email_pass": email_pass
            })
            st.session_state["latest_result"] = res.json()
            st.success("✅ Scan Complete")

# === Live Result ===
if "latest_result" in st.session_state:
    st.subheader("📦 Latest Scan Output")
    st.json(st.session_state["latest_result"])

# === Scan History ===
st.subheader("📚 Past Scans")
logs = read_logs()
df = pd.DataFrame(logs)
df["timestamp"] = pd.to_datetime(df["timestamp"])
df["alert"] = df["status"].apply(lambda x: "⚠️" if x == "issue" else "✅")

# Filters
col1, col2 = st.columns(2)
with col1:
    status_filter = st.selectbox("Status", options=["All", "complete", "issue"])
with col2:
    search = st.text_input("Search Query")

if status_filter != "All":
    df = df[df["status"] == status_filter]
if search:
    df = df[df["query"].str.contains(search)]

st.dataframe(df[["timestamp", "query", "status", "alert"]])

# === Bulk Scan ===
st.markdown("---")
st.subheader("📤 Bulk CSV Scan")
csv_file = st.file_uploader("Upload CSV with 'query' column", type="csv")
if csv_file:
    df_csv = pd.read_csv(csv_file)
    if "query" in df_csv.columns:
        st.success(f"{len(df_csv)} entries found.")
        if st.button("Start Bulk Scan"):
            progress = st.progress(0)
            for i, q in enumerate(df_csv["query"]):
                try:
                    res = requests.post(API_URL, json={
                        "query": q,
                        "serpapi_key": serpapi_key,
                        "gemini_key": gemini_key,
                        "email_pass": email_pass
                    })
                    st.session_state[f"result_{q}"] = res.json()
                except Exception as e:
                    st.warning(f"Failed to scan: {q} ({e})")
                progress.progress((i+1)/len(df_csv))
            st.success("Bulk Scan Complete ✅")

# Show Bulk Summary
bulk_results = [v for k, v in st.session_state.items() if k.startswith("result_")]
if bulk_results:
    st.subheader("📊 Bulk Scan Results")
    summary_df = pd.DataFrame([{
        "Query": r.get("report", {}).get("file", "").replace("report_", "").replace(".md", ""),
        "Abuse Score": r.get("threatintel", {}).get("abuseipdb", {}).get("abuseConfidenceScore", "N/A"),
        "VT Rep": r.get("threatintel", {}).get("virustotal", {}).get("reputation", "N/A"),
        "Status": r.get("selftest", {}).get("status", "N/A"),
        "Alert": "⚠️" if r.get("alert") else "✅"
    } for r in bulk_results])
    st.dataframe(summary_df)
