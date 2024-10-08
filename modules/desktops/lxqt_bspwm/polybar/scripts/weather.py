#!/bin/python
# -*- coding: utf-8 -*-

# Procedure
# Goto https://openweathermap.org/city
#fill in your CITY
#
#https://openweathermap.org/city/5586437
# Get the cidty code at the end and create an account on the website
# create an api key (free)

import requests
CITY = "5586437" # City ID
API_KEY = "b41c8f3cc644ab48a5b91f9ab0f12c83"
UNITS = "Imperial"
UNIT_KEY = "F"

#REQ = requests.get("http://api.openweathermap.org/data/2.5/weather?id={}&appid={}&units=metric&lang=en".format(CITY, API_KEY))
REQ = requests.get("http://api.openweathermap.org/data/2.5/weather?id={}&appid={}&units={}".format(CITY, API_KEY, UNITS))
try:
    # HTTP CODE = OK
    if REQ.status_code == 200:
        CURRENT = REQ.json()["weather"][0]["description"].capitalize()
        TEMP = int(float(REQ.json()["main"]["temp"]))
        print("{}, {} °{}".format(CURRENT, TEMP, UNIT_KEY))
    else:
        print("Error: BAD HTTP STATUS CODE " + str(REQ.status_code))
except (ValueError, IOError):
        print("Error: Unable print the data")

