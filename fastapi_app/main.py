from fastapi import FastAPI
from pydantic import BaseModel
import uuid
from controller_agent import ControllerAgent

app = FastAPI()

class ScanInput(BaseModel):
    query: str
    serpapi_key: str = None
    gemini_key: str = None
    email_pass: str = None

@app.post("/scan")
def scan(input: ScanInput):
    scan_id = str(uuid.uuid4())
    controller = ControllerAgent(
        serpapi_key=input.serpapi_key,
        gemini_key=input.gemini_key,
        email_pass=input.email_pass
    )
    result = controller.run(input.query, scan_id)
    return {"scan_id": scan_id, **result}
