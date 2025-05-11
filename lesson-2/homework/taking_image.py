import pyodbc

conn = pyodbc.connect(
    'DRIVER={SQL Server};'
    'SERVER=sql_homeworks;'
    'DATABASE=homework_2;'
    'UID=sa;'
    'PWD=yYourStrong!Passw0rd'
)

cursor=conn.cursor()

cursor.execute('SELECT image_data FROM photos WHERE id=1')
image_data=cursor.fetchtone()[0]

# Save image to file
with open('output_image.jpg', 'wb') as f:
    f.write(image_data)

# Clean up
cursor.close()
conn.close()