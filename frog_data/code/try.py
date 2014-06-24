# import csv
#
# with open('../csv/dataset.csv', 'rb') as csvfile:
#   reader = csv.reader(csvfile, delimiter=',', quotechar='"')
#   for row in reader:
#     print row

import sqlite3

path = '/Users/xiaoyang.feng/Documents/Code/OCHA/data-for-frog/frog_data/db/cps_model_db.sqlite'
conn = sqlite3.connect(path)
c = conn.cursor()

c.execute('SELECT * FROM value WHERE indID = "FY020"')
# print c.fetchall()
# row = c.fetchone()
# for row in c:
#   print row

arr = c.fetchall()

print len(arr)

conn.close()
