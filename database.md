1. 账户信息 -> user (type) users
   1. user_id 主键 INTEGER
   2. name 姓名 TEXT
   3. account 账号 TEXT
   4. password 密码 TEXT
   5. type 类型 INTEGER (0 -> 学生，1 -> 教师，2 -> 管理员)
   6. information TEXT (json)
   7. image BINARY null
2. 理由库 reason
   1. reason_id 主键 INTEGER
   2. user_id INTEGER
   3. content TEXT
3. 申请表单 application
   1. application_id 主键 INTEGER
   2. student_id INTEGER
   3. teacher_id INTEGER
   4. content TEXT (json)
   5. status INTEGER (0 -> 未审批，1 -> 通过，2 -> 未通过)
4. 聊天 chat
   1. chat_id 主键 INTEGER
   2. from_id INTEGER
   3. to_id INTEGER
   4. content TEXT
   5. time DATETIME
5. 匹配表 match
   1. match_id 主键 INTEGER
   2. student_id INTEGER
   3. teacher_id INTEGER
6. 教师信息 teachers
