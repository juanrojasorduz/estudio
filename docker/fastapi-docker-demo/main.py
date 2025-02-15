import os
from fastapi import FastAPI
from random import choice


app = FastAPI()



@app.get("/")
def chuck_facts():
    current_dir = os.path.dirname(os.path.realpath(__file__))
    with open(f"{current_dir}/assets/curated_facts.txt", "r") as facts_file:
        facts_list = facts_file.read().splitlines()
        random_fact = choice(facts_list)
    return {"fact": random_fact}
