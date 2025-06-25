class A2AProtocol:
    @staticmethod
    def create_message(sender, receiver, task_type, payload):
        return {
            "from": sender,
            "to": receiver,
            "type": task_type,
            "payload": payload
        }

    @staticmethod
    def route(message, agents):
        receiver = message["to"]
        if receiver in agents:
            return agents[receiver].handle_task(message["payload"]["query"])
        return {"error": f"No agent found with name {receiver}"}
