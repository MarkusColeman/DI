import json

sampleJson = """{ 
   "company":{ 
      "employee":{ 
         "name":"emma",
         "payable":{ 
            "salary":7000,
            "bonus":800
         }
      }
   }
}"""


data = json.loads(sampleJson)


print(data["company"]["employee"]["payable"]["salary"])

data["company"]["employee"]["birth_date"] = "1990-01-01"

with open("updated_data.json", "w") as file:
    json.dump(data, file, indent=4)


