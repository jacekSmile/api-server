import sqlite3
import sys

# 要求邮箱是唯一的
emails = set()

def show_info(row):
    account = "".join([str(ord(item)) for item in row[1]])
    print("\ninsert into users (name, account, password, type_info, information, image) values (\n"
          f"    '{row[1]}',\n"
          f"    '{account}',\n"
          "    '123456',\n"
          "    1,\n"
          f'    \'\x7b"name": "{row[1]}", "department": "{row[2]}", "office": "{row[3]}", "phone_number": "{row[4]}", "email": "{row[5]}", "time": "{row[-1]}"\x7d\',\n'
          "    null\n"
          ");", file=sys.stdout)  # Redirect output to sys.stdout


# Redirect standard output to a file
sys.stdout = open('output.txt', 'w')

# 连接到数据库
conn = sqlite3.connect('data.db')

# 创建游标对象
cursor = conn.cursor()

# 执行查询语句
cursor.execute('SELECT * FROM teachers')

# 获取查询结果
results = cursor.fetchall()

# 遍历结果
for row in results:
    show_info(row)

# 关闭游标和连接
cursor.close()
conn.close()

# Restore standard output
sys.stdout.close()
sys.stdout = sys.__stdout__
