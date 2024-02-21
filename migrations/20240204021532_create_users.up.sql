create table users (
    id integer primary key not null,
    name text not null,
    account text not null,
    password text not null,
    type_info integer not null,
    information text not null,
    image blob
);

create unique index users_account_index on users (account);

-- 测试数据
insert into users (name, account, password, type_info, information, image) values (
    '杨楚洁',
    '202203150323',
    '123456',
    0,
    '{"name": "杨楚洁", "class_room": "软外2202班", "phone_number": "19856655987", "political_status": "团员", "email": "2@qq.om", "home_address": "翻斗花园22022020号", "interesting": "写代码", "employment_intention": "程序员", "project_experience": "寒假软件设计", "honors": "CTF省一"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '范菁',
    '3353933729',
    '123456',
    1,
    '{"name": "范菁", "department": "学院办公室（计算机软件研究所）", "office": "A404", "phone_number": "85290116", "email": "fanjing@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '沈国江',
    '277842226927743',
    '123456',
    1,
    '{"name": "沈国江", "department": "学院办公室（计算机智能系统研究所） ", "office": "A408", "phone_number": "85290397", "email": "gjshen1975@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '陈铁明',
    '384723808126126',
    '123456',
    1,
    '{"name": "陈铁明", "department": "学院办公室（计算机软件研究所）", "office": "A406", "phone_number": "85290809", "email": "tmchen@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '陈朋',
    '3847226379',
    '123456',
    1,
    '{"name": "陈朋", "department": "学院办公室（计算机网络研究所）", "office": "A410", "phone_number": "85290115", "email": "chenpeng@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '毛诗焙',
    '276113579928953',
    '123456',
    1,
    '{"name": "毛诗焙", "department": "学院办公室", "office": "A412", "phone_number": "85290215", "email": "alice163@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '陈蓉蓉',
    '384723399333993',
    '123456',
    1,
    '{"name": "陈蓉蓉", "department": "学院办公室", "office": "A414", "phone_number": "85290668", "email": "crr@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '陈婉君',
    '384722311321531',
    '123456',
    1,
    '{"name": "陈婉君", "department": "学院办公室", "office": "D437", "phone_number": "85290667", "email": "wanjun@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '边林洁',
    '367932651927905',
    '123456',
    1,
    '{"name": "边林洁", "department": "学院办公室", "office": "A416", "phone_number": "85290136", "email": "blj@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '李琰琰',
    '264462974429744',
    '123456',
    1,
    '{"name": "李琰琰", "department": "学院办公室", "office": "D437", "phone_number": "85290676", "email": "lyy1981@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '沈雁飞',
    '277843859339134',
    '123456',
    1,
    '{"name": "沈雁飞", "department": "学院办公室", "office": "D437", "phone_number": "85290676", "email": "shenyanfei@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '葛易林',
    '338832613126519',
    '123456',
    1,
    '{"name": "葛易林", "department": "学院办公室", "office": "A414", "phone_number": "85290525", "email": "gyl@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '王春薇',
    '295792614934183',
    '123456',
    1,
    '{"name": "王春薇", "department": "学院办公室", "office": "A414", "phone_number": "85290668", "email": "sec@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '谭郁',
    '3588537057',
    '123456',
    1,
    '{"name": "谭郁", "department": "学院办公室", "office": "D437", "phone_number": "85290667", "email": "camp@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '杨小苏',
    '264722356733487',
    '123456',
    1,
    '{"name": "杨小苏", "department": "学院办公室", "office": "A416", "phone_number": "85290136", "email": "yangxiaosu@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '郑妘',
    '3707322936',
    '123456',
    1,
    '{"name": "郑妘", "department": "学院办公室", "office": "A416", "phone_number": "85290795", "email": "zhengy@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '朱文博',
    '264172599121338',
    '123456',
    1,
    '{"name": "朱文博", "department": "学生工作办公室", "office": "D417/419", "phone_number": "85290715", "email": "zhuwenbo@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '官馨馨',
    '234483933639336',
    '123456',
    1,
    '{"name": "官馨馨", "department": "学生工作办公室", "office": "D417/419", "phone_number": "85290085", "email": "guanxx@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '周超',
    '2160836229',
    '123456',
    1,
    '{"name": "周超", "department": "学生工作办公室", "office": "D421/423", "phone_number": "85290681", "email": "chaozhou@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '张苗苗',
    '243523349533495',
    '123456',
    1,
    '{"name": "张苗苗", "department": "学生工作办公室", "office": "D417/419", "phone_number": "85290715", "email": "zhangmm@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '楼柯辰',
    '270042660736784',
    '123456',
    1,
    '{"name": "楼柯辰", "department": "学生工作办公室", "office": "D421/423", "phone_number": "85290122", "email": "lkc@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '刘丹',
    '2101620025',
    '123456',
    1,
    '{"name": "刘丹", "department": "学生工作办公室", "office": "D421/423", "phone_number": "85290681", "email": "601481123@qq.com", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '俞舒澜',
    '204463329828572',
    '123456',
    1,
    '{"name": "俞舒澜", "department": "学生工作办公室", "office": "D421/423", "phone_number": "85290665", "email": "yu5991@aliyun.com", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '沈祎佳',
    '277843105420339',
    '123456',
    1,
    '{"name": "沈祎佳", "department": "学生工作办公室", "office": "D421/423", "phone_number": "85290122", "email": "shenyijia@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '杨禹',
    '2647231161',
    '123456',
    1,
    '{"name": "杨禹", "department": "学生工作办公室", "office": "D417/419", "phone_number": "85290085", "email": "1571238389@qq.com", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '练义欣',
    '324512004127427',
    '123456',
    1,
    '{"name": "练义欣", "department": "学生工作办公室", "office": "D421/423", "phone_number": "85290665", "email": "303299858@qq.com", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '韩姝盈',
    '388892300530408',
    '123456',
    1,
    '{"name": "韩姝盈", "department": "学生工作办公室", "office": "计D423", "phone_number": "85290122", "email": "649908199@qq.com", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '吴琦聪',
    '215562973432874',
    '123456',
    1,
    '{"name": "吴琦聪", "department": "学生工作办公室", "office": "尚12-201", "phone_number": "88320571", "email": "185724873@qq.com", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '刘泽辰',
    '210162790136784',
    '123456',
    1,
    '{"name": "刘泽辰", "department": "学生工作办公室", "office": "D421/423", "phone_number": "85290665", "email": "2502976035@qq.com", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '金矫波',
    '373293069927874',
    '123456',
    1,
    '{"name": "金矫波", "department": "学生工作办公室", "office": "计D423", "phone_number": "85290122", "email": "3432536713@qq.com", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '朱明杰',
    '264172612626480',
    '123456',
    1,
    '{"name": "朱明杰", "department": "学生工作办公室", "office": "尚12#201", "phone_number": "88320571", "email": "1430553944@qq.com", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '龙胜春',
    '408573298826149',
    '123456',
    1,
    '{"name": "龙胜春", "department": "计算机教学研究中心", "office": "B414", "phone_number": "85290515", "email": "longsc@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '韩姗姗',
    '388892299922999',
    '123456',
    1,
    '{"name": "韩姗姗", "department": "计算机教学研究中心", "office": "B414", "phone_number": "", "email": "hanss@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '戴小春',
    '251402356726149',
    '123456',
    1,
    '{"name": "戴小春", "department": "计算机教学研究中心", "office": "B411", "phone_number": "", "email": "spring@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '董灵平',
    '338912878924179',
    '123456',
    1,
    '{"name": "董灵平", "department": "计算机教学研究中心", "office": "B411", "phone_number": "", "email": "dlp@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '郭永艳',
    '371012770433395',
    '123456',
    1,
    '{"name": "郭永艳", "department": "计算机教学研究中心", "office": "A502", "phone_number": "85290527", "email": "gyy@zjut.edu.cn ", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '黄洪',
    '4064427946',
    '123456',
    1,
    '{"name": "黄洪", "department": "计算机教学研究中心", "office": "B411", "phone_number": "", "email": "huanghong@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '李坚',
    '2644622362',
    '123456',
    1,
    '{"name": "李坚", "department": "计算机教学研究中心", "office": "B411/A416", "phone_number": "85290138", "email": "lij21cn@163.com", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '廖锋峰',
    '242783815523792',
    '123456',
    1,
    '{"name": "廖锋峰", "department": "计算机教学研究中心", "office": "B414", "phone_number": "", "email": "lff@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '毛国红',
    '276112226932418',
    '123456',
    1,
    '{"name": "毛国红", "department": "计算机教学研究中心", "office": "B318", "phone_number": "", "email": "mgh@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '王英姿',
    '295793352123039',
    '123456',
    1,
    '{"name": "王英姿", "department": "计算机教学研究中心", "office": "B510/B512", "phone_number": "85290613", "email": "wyz@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '周德龙',
    '216082450340857',
    '123456',
    1,
    '{"name": "周德龙", "department": "计算机教学研究中心", "office": "B510/B512", "phone_number": "85290613", "email": "zdl@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '董天阳',
    '338912282538451',
    '123456',
    1,
    '{"name": "董天阳", "department": "计算机软件研究所", "office": "A206/A208", "phone_number": "", "email": "dty@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '程时伟',
    '312432610220255',
    '123456',
    1,
    '{"name": "程时伟", "department": "计算机软件研究所", "office": "A206/A208", "phone_number": "", "email": "swc@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '曹斌',
    '2636125996',
    '123456',
    1,
    '{"name": "曹斌", "department": "计算机软件研究所", "office": "A201/203", "phone_number": "", "email": "bincao@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '陈波',
    '3847227874',
    '123456',
    1,
    '{"name": "陈波", "department": "计算机软件研究所", "office": "A210/A212", "phone_number": "", "email": "cb@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '何玲娜',
    '203092961823068',
    '123456',
    1,
    '{"name": "何玲娜", "department": "计算机软件研究所", "office": "D121", "phone_number": "", "email": "coignhln@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '李波',
    '2644627874',
    '123456',
    1,
    '{"name": "李波", "department": "计算机软件研究所", "office": "A210/A212", "phone_number": "", "email": "lib@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '李甜甜',
    '264462998029980',
    '123456',
    1,
    '{"name": "李甜甜", "department": "计算机软件研究所", "office": "A202/A204", "phone_number": "", "email": "ttli89@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '李小薪',
    '264462356734218',
    '123456',
    1,
    '{"name": "李小薪", "department": "计算机软件研究所", "office": "A210/A212", "phone_number": "", "email": "mordekai@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '李英龙',
    '264463352140857',
    '123456',
    1,
    '{"name": "李英龙", "department": "计算机软件研究所", "office": "A504", "phone_number": "85290527", "email": "liyinglong@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '吕明琪',
    '215252612629738',
    '123456',
    1,
    '{"name": "吕明琪", "department": "计算机软件研究所", "office": "A210/A212", "phone_number": "", "email": "mingqilv@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '梅建萍',
    '267572431433805',
    '123456',
    1,
    '{"name": "梅建萍", "department": "计算机软件研究所", "office": "A202/A204", "phone_number": "85290034", "email": "jpmei@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '邱杰凡',
    '370412648020961',
    '123456',
    1,
    '{"name": "邱杰凡", "department": "计算机软件研究所", "office": "A201/203", "phone_number": "", "email": "qiujiefan@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '沈瑛',
    '2778429787',
    '123456',
    1,
    '{"name": "沈瑛", "department": "计算机软件研究所", "office": "A206/A208", "phone_number": "", "email": "shenying@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '王婷',
    '2957923159',
    '123456',
    1,
    '{"name": "王婷", "department": "计算机软件研究所", "office": "A202/A204", "phone_number": "85290034", "email": "wangting@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '熊丽荣',
    '290662002933635',
    '123456',
    1,
    '{"name": "熊丽荣", "department": "计算机软件研究所", "office": "A206/A208", "phone_number": "", "email": "lilybear@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '燕锐',
    '2914138160',
    '123456',
    1,
    '{"name": "燕锐", "department": "计算机软件研究所", "office": "", "phone_number": "", "email": "ryan@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '张天明',
    '243522282526126',
    '123456',
    1,
    '{"name": "张天明", "department": "计算机软件研究所", "office": "", "phone_number": "", "email": "tmzhang@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '朱添田',
    '264172815530000',
    '123456',
    1,
    '{"name": "朱添田", "department": "计算机软件研究所", "office": "A210/A212", "phone_number": "", "email": "ttzhu@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '侯晨煜',
    '203992621629020',
    '123456',
    1,
    '{"name": "侯晨煜", "department": "计算机软件研究所", "office": "A210/A212", "phone_number": "", "email": "houcy@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '王佳星',
    '295792033926143',
    '123456',
    1,
    '{"name": "王佳星", "department": "计算机软件研究所", "office": "", "phone_number": "", "email": "wjx@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '江颉',
    '2774339049',
    '123456',
    1,
    '{"name": "江颉", "department": "计算机软件研究所", "office": "", "phone_number": "", "email": "jj@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '陈胜勇',
    '384723298821191',
    '123456',
    1,
    '{"name": "陈胜勇", "department": "计算机视觉研究所", "office": "A310/312", "phone_number": "85290085", "email": "csy@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '白琮',
    '3033329742',
    '123456',
    1,
    '{"name": "白琮", "department": "计算机视觉研究所", "office": "B315", "phone_number": "", "email": "congbai@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '管秋',
    '3164931179',
    '123456',
    1,
    '{"name": "管秋", "department": "计算机视觉研究所", "office": "D339", "phone_number": "85290529", "email": "gq@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '产思贤',
    '201352460536132',
    '123456',
    1,
    '{"name": "产思贤", "department": "计算机视觉研究所", "office": "B313", "phone_number": "", "email": "sxchan@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '高华',
    '3964021326',
    '123456',
    1,
    '{"name": "高华", "department": "计算机视觉研究所", "office": "B321", "phone_number": "", "email": "ghua@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '郭东岩',
    '371011999623721',
    '123456',
    1,
    '{"name": "郭东岩", "department": "计算机视觉研究所", "office": "B317", "phone_number": "", "email": "guodongyan@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '郝鹏翼',
    '370854052732764',
    '123456',
    1,
    '{"name": "郝鹏翼", "department": "计算机视觉研究所", "office": "B318", "phone_number": "", "email": "haopy@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '胡海根',
    '329932802326681',
    '123456',
    1,
    '{"name": "胡海根", "department": "计算机视觉研究所", "office": "D323", "phone_number": "", "email": "hghu@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '姜娓娓',
    '230042305923059',
    '123456',
    1,
    '{"name": "姜娓娓", "department": "计算机视觉研究所", "office": "A305", "phone_number": "", "email": "jwwzjut@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '刘盛',
    '2101630427',
    '123456',
    1,
    '{"name": "刘盛", "department": "计算机视觉研究所", "office": "D321", "phone_number": "", "email": "edliu@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '汪晓妍',
    '277542619522925',
    '123456',
    1,
    '{"name": "汪晓妍", "department": "计算机视觉研究所", "office": "B314", "phone_number": "", "email": "xiaoyanwang@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '王丽萍',
    '295792002933805',
    '123456',
    1,
    '{"name": "王丽萍", "department": "计算机视觉研究所", "office": "", "phone_number": "", "email": "wlp@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '王万良',
    '295791997533391',
    '123456',
    1,
    '{"name": "王万良", "department": "计算机视觉研究所", "office": "A302", "phone_number": "85290172", "email": "wwl@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '周乾伟',
    '216082009420255',
    '123456',
    1,
    '{"name": "周乾伟", "department": "计算机视觉研究所", "office": "B321", "phone_number": "", "email": "zqw@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '穆攀',
    '3130225856',
    '123456',
    1,
    '{"name": "穆攀", "department": "计算机视觉研究所", "office": "B320", "phone_number": "", "email": "panmu@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '王铮',
    '2957938126',
    '123456',
    1,
    '{"name": "王铮", "department": "计算机视觉研究所", "office": "", "phone_number": "", "email": "zhengwang@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '王琼',
    '2957929756',
    '123456',
    1,
    '{"name": "王琼", "department": "计算机视觉研究所", "office": "", "phone_number": "", "email": "wangqiong@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '丁维龙',
    '199693250040857',
    '123456',
    1,
    '{"name": "丁维龙", "department": "计算机网络研究所", "office": "D537", "phone_number": "", "email": "wlding@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '宦若虹',
    '234623350934425',
    '123456',
    1,
    '{"name": "宦若虹", "department": "计算机网络研究所", "office": "A509", "phone_number": "", "email": "huanrh@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '孙国道',
    '233852226936947',
    '123456',
    1,
    '{"name": "孙国道", "department": "计算机网络研究所", "office": "", "phone_number": "", "email": "guodao@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '边继东',
    '367933248719996',
    '123456',
    1,
    '{"name": "边继东", "department": "计算机网络研究所", "office": "A502", "phone_number": "85290527", "email": "bjd@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '程珍',
    '3124329645',
    '123456',
    1,
    '{"name": "程珍", "department": "计算机网络研究所", "office": "A506", "phone_number": "", "email": "chengzhen@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '池凯凯',
    '277442097520975',
    '123456',
    1,
    '{"name": "池凯凯", "department": "计算机网络研究所", "office": "A512", "phone_number": "", "email": "kkchi@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '范玉雷',
    '335392957738647',
    '123456',
    1,
    '{"name": "范玉雷", "department": "计算机网络研究所", "office": "A502", "phone_number": "85290527", "email": "fyl815@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '高楠',
    '3964026976',
    '123456',
    1,
    '{"name": "高楠", "department": "计算机网络研究所", "office": "D227", "phone_number": "", "email": "gaonan@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '龚卫华',
    '408582135521326',
    '123456',
    1,
    '{"name": "龚卫华", "department": "计算机网络研究所", "office": "A506", "phone_number": "", "email": "whgong@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '胡萍',
    '3299333805',
    '123456',
    1,
    '{"name": "胡萍", "department": "计算机网络研究所", "office": "A504", "phone_number": "85290527", "email": "pinghu@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '黄亮',
    '4064420142',
    '123456',
    1,
    '{"name": "黄亮", "department": "计算机网络研究所", "office": "A515", "phone_number": "", "email": "lianghuang@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '蒋莉',
    '3393133673',
    '123456',
    1,
    '{"name": "蒋莉", "department": "计算机网络研究所", "office": "", "phone_number": "", "email": "jl@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '雷杰',
    '3864726480',
    '123456',
    1,
    '{"name": "雷杰", "department": "计算机网络研究所", "office": "", "phone_number": "", "email": "jasonlei@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '雷艳静',
    '386473339538745',
    '123456',
    1,
    '{"name": "雷艳静", "department": "计算机网络研究所", "office": "D229", "phone_number": "", "email": "leiyj@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '李燕君',
    '264462914121531',
    '123456',
    1,
    '{"name": "李燕君", "department": "计算机网络研究所", "office": "A508", "phone_number": "", "email": "yjli@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '梁浩然',
    '267532800928982',
    '123456',
    1,
    '{"name": "梁浩然", "department": "计算机网络研究所", "office": "", "phone_number": "", "email": "haoran@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '刘晓莹',
    '210162619533721',
    '123456',
    1,
    '{"name": "刘晓莹", "department": "计算机网络研究所", "office": "A516", "phone_number": "", "email": "xiaoyingliu@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '刘义鹏',
    '210162004140527',
    '123456',
    1,
    '{"name": "刘义鹏", "department": "计算机网络研究所", "office": "", "phone_number": "", "email": "liuyipeng@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '毛科技',
    '276113118525216',
    '123456',
    1,
    '{"name": "毛科技", "department": "计算机网络研究所", "office": "A515", "phone_number": "", "email": "maokeji@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '田贤忠',
    '300003613224544',
    '123456',
    1,
    '{"name": "田贤忠", "department": "计算机网络研究所", "office": "A510", "phone_number": "", "email": "txz@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '王海霞',
    '295792802338686',
    '123456',
    1,
    '{"name": "王海霞", "department": "计算机网络研究所", "office": "", "phone_number": "", "email": "hxwang@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '夏明',
    '2279926126',
    '123456',
    1,
    '{"name": "夏明", "department": "计算机网络研究所", "office": "A509", "phone_number": "", "email": "xiaming@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '徐利锋',
    '244642103338155',
    '123456',
    1,
    '{"name": "徐利锋", "department": "计算机网络研究所", "office": "A504", "phone_number": "85290527", "email": "lfxu@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '杨良怀',
    '264723339124576',
    '123456',
    1,
    '{"name": "杨良怀", "department": "计算机网络研究所", "office": "D539", "phone_number": "", "email": "yanglh@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '于明远',
    '201102612636828',
    '123456',
    1,
    '{"name": "于明远", "department": "计算机网络研究所", "office": "A511", "phone_number": "", "email": "ymy@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '张书彬',
    '243522007024428',
    '123456',
    1,
    '{"name": "张书彬", "department": "计算机网络研究所", "office": "", "phone_number": "", "email": "zhangshubin@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '赵冬冬',
    '362132090820908',
    '123456',
    1,
    '{"name": "赵冬冬", "department": "计算机网络研究所", "office": "", "phone_number": "", "email": "zhaodd@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '郑红波',
    '370733241827874',
    '123456',
    1,
    '{"name": "郑红波", "department": "计算机网络研究所", "office": "A504", "phone_number": "85290527", "email": "zhb@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '郑可琛',
    '370732148729723',
    '123456',
    1,
    '{"name": "郑可琛", "department": "计算机网络研究所", "office": "A516", "phone_number": "", "email": "kechenzheng@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '张怡龙',
    '243522460940857',
    '123456',
    1,
    '{"name": "张怡龙", "department": "计算机网络研究所", "office": "C508", "phone_number": "", "email": "zhangyilong@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '刘健',
    '2101620581',
    '123456',
    1,
    '{"name": "刘健", "department": "计算机网络研究所", "office": "", "phone_number": "", "email": "jliu83@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '杨哲',
    '2647221746',
    '123456',
    1,
    '{"name": "杨哲", "department": "计算机网络研究所", "office": "", "phone_number": "", "email": "zheyang@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '魏欣晨',
    '397592742726216',
    '123456',
    1,
    '{"name": "魏欣晨", "department": "计算机网络研究所", "office": "", "phone_number": "", "email": "weixinchen@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '党源杰',
    '208262830426480',
    '123456',
    1,
    '{"name": "党源杰", "department": "计算机网络研究所", "office": "C512", "phone_number": "", "email": "dangyuanjie@qq.com", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '高海东',
    '396402802319996',
    '123456',
    1,
    '{"name": "高海东", "department": "计算机网络研究所", "office": "", "phone_number": "", "email": "gaohaidong@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '梁荣华',
    '267533363521326',
    '123456',
    1,
    '{"name": "梁荣华", "department": "计算机网络研究所", "office": "A402", "phone_number": "85290071", "email": "rhliang@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '吴一鸣',
    '215561996840483',
    '123456',
    1,
    '{"name": "吴一鸣", "department": "计算机网络研究所（博士后）", "office": "C512", "phone_number": "", "email": "ymw@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '张玉繁',
    '243522957732321',
    '123456',
    1,
    '{"name": "张玉繁", "department": "计算机网络研究所（博士后）", "office": "", "phone_number": "", "email": "yufanzhang@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '赵邢',
    '3621337026',
    '123456',
    1,
    '{"name": "赵邢", "department": "计算机网络研究所（博士后）", "office": "C511", "phone_number": "", "email": "xing@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '谢亮',
    '3587420142',
    '123456',
    1,
    '{"name": "谢亮", "department": "计算机网络研究所（博士后）", "office": "C512", "phone_number": "", "email": "lilydedbb@gmail.com", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '孙昊浩',
    '233852612228009',
    '123456',
    1,
    '{"name": "孙昊浩", "department": "计算机网络研究所（博士后）", "office": "", "phone_number": "", "email": "", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '郑建炜',
    '370732431428828',
    '123456',
    1,
    '{"name": "郑建炜", "department": "计算机智能系统研究所", "office": "D329", "phone_number": "", "email": "zjw@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '姚信威',
    '230022044923041',
    '123456',
    1,
    '{"name": "姚信威", "department": "计算机智能系统研究所", "office": "B310/B312", "phone_number": "", "email": "xwyao@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '黄鲜萍',
    '406444009233805',
    '123456',
    1,
    '{"name": "黄鲜萍", "department": "计算机智能系统研究所", "office": "D329", "phone_number": "", "email": "hxp@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '曹迪',
    '2636136842',
    '123456',
    1,
    '{"name": "曹迪", "department": "计算机智能系统研究所", "office": "D229", "phone_number": "", "email": "dicao@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '郭行波',
    '371013489227874',
    '123456',
    1,
    '{"name": "郭行波", "department": "计算机智能系统研究所", "office": "B306/B308", "phone_number": "", "email": "gxb@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '胡亚红',
    '329932012232418',
    '123456',
    1,
    '{"name": "胡亚红", "department": "计算机智能系统研究所", "office": "A508", "phone_number": "", "email": "huyahong@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '黄伟',
    '4064420255',
    '123456',
    1,
    '{"name": "黄伟", "department": "计算机智能系统研究所", "office": "B306/B308", "phone_number": "", "email": "huangwei@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '蒋一波',
    '339311996827874',
    '123456',
    1,
    '{"name": "蒋一波", "department": "计算机智能系统研究所", "office": "B306/B308", "phone_number": "", "email": "jyb106@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '孔祥杰',
    '233803107726480',
    '123456',
    1,
    '{"name": "孔祥杰", "department": "计算机智能系统研究所", "office": "D227", "phone_number": "", "email": "xjkong@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '李强',
    '2644624378',
    '123456',
    1,
    '{"name": "李强", "department": "计算机智能系统研究所", "office": "B310/B312", "phone_number": "", "email": "qiangli@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '刘端阳',
    '210163147138451',
    '123456',
    1,
    '{"name": "刘端阳", "department": "计算机智能系统研究所", "office": "B306/B308", "phone_number": "", "email": "ldy@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '刘志',
    '2101624535',
    '123456',
    1,
    '{"name": "刘志", "department": "计算机智能系统研究所", "office": "D319", "phone_number": "", "email": "lzhi@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '毛家发',
    '276112347821457',
    '123456',
    1,
    '{"name": "毛家发", "department": "计算机智能系统研究所", "office": "B406/B408", "phone_number": "85290535", "email": "maojiafa@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '许金山',
    '357683732923665',
    '123456',
    1,
    '{"name": "许金山", "department": "计算机智能系统研究所", "office": "B306/B308", "phone_number": "", "email": "jxu@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '杨曦',
    '2647226342',
    '123456',
    1,
    '{"name": "杨曦", "department": "计算机智能系统研究所", "office": "B306/B308", "phone_number": "", "email": "xyang@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '朱李楠',
    '264172644626976',
    '123456',
    1,
    '{"name": "朱李楠", "department": "计算机智能系统研究所", "office": "", "phone_number": "", "email": "zln@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '李岩',
    '2644623721',
    '123456',
    1,
    '{"name": "李岩", "department": "计算机智能系统研究所", "office": "", "phone_number": "", "email": "liyan19@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '杜嘉欣',
    '264602202527427',
    '123456',
    1,
    '{"name": "杜嘉欣", "department": "计算机智能系统研究所", "office": "", "phone_number": "", "email": "dujiaxin@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '徐宏辉',
    '244642343936745',
    '123456',
    1,
    '{"name": "徐宏辉", "department": "计算机智能系统研究所（博士后）", "office": "B306/B308", "phone_number": "", "email": "xhh@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '王卫红',
    '295792135532418',
    '123456',
    1,
    '{"name": "王卫红", "department": "空间信息计算研究所  ", "office": "D519", "phone_number": "85290161", "email": "wwh@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '程宏兵',
    '312432343920853',
    '123456',
    1,
    '{"name": "程宏兵", "department": "空间信息计算研究所", "office": "B513/B515", "phone_number": "85290027", "email": "chenghb@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '李伟',
    '2644620255',
    '123456',
    1,
    '{"name": "李伟", "department": "空间信息计算研究所", "office": "B513/B515", "phone_number": "85290027", "email": "liwzjut@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '李曲',
    '2644626354',
    '123456',
    1,
    '{"name": "李曲", "department": "空间信息计算研究所", "office": "B513/B515", "phone_number": "85290027", "email": "liqu@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '王春平',
    '295792614924179',
    '123456',
    1,
    '{"name": "王春平", "department": "空间信息计算研究所", "office": "B513/B515", "phone_number": "85290027", "email": "wangcp@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '王松',
    '2957926494',
    '123456',
    1,
    '{"name": "王松", "department": "空间信息计算研究所", "office": "B513/B515", "phone_number": "85290027", "email": "ws@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '吴炜',
    '2155628828',
    '123456',
    1,
    '{"name": "吴炜", "department": "空间信息计算研究所", "office": "B513/B515", "phone_number": "85290027", "email": "wuwei@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '夏列钢',
    '227992101538050',
    '123456',
    1,
    '{"name": "夏列钢", "department": "空间信息计算研究所", "office": "B513/B515", "phone_number": "85290027", "email": "xialg@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '杨海平',
    '264722802324179',
    '123456',
    1,
    '{"name": "杨海平", "department": "空间信息计算研究所", "office": "B513/B515", "phone_number": "85290027", "email": "yanghp@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '张晓丽',
    '243522619520029',
    '123456',
    1,
    '{"name": "张晓丽", "department": "空间信息计算研究所", "office": "", "phone_number": "", "email": "xiaolizhang@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '李澎林',
    '264462855826519',
    '123456',
    1,
    '{"name": "李澎林", "department": "空间信息计算研究所", "office": "", "phone_number": "", "email": "", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '郑河荣',
    '370732782733635',
    '123456',
    1,
    '{"name": "郑河荣", "department": "人工智能工程中心", "office": "B522/B524", "phone_number": "56075071", "email": "hailiang@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '潘翔',
    '2850432724',
    '123456',
    1,
    '{"name": "潘翔", "department": "人工智能工程中心", "office": "B522/B524", "phone_number": "56075072", "email": "panx@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '崔滢',
    '2382828386',
    '123456',
    1,
    '{"name": "崔滢", "department": "人工智能工程中心", "office": "B522/B524", "phone_number": "", "email": "cuiying@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '季白杨',
    '233953033326472',
    '123456',
    1,
    '{"name": "季白杨", "department": "人工智能工程中心", "office": "D119", "phone_number": "", "email": "jby@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '王鑫',
    '2957937995',
    '123456',
    1,
    '{"name": "王鑫", "department": "人工智能工程中心", "office": "B522/B524", "phone_number": "56075072", "email": "xinw@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '王涌',
    '2957928044',
    '123456',
    1,
    '{"name": "王涌", "department": "人工智能工程中心", "office": "D227", "phone_number": "", "email": "wy@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '张永良',
    '243522770433391',
    '123456',
    1,
    '{"name": "张永良", "department": "人工智能工程中心", "office": "B406/B408", "phone_number": "85290535", "email": "titanzhang@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '赵小敏',
    '362132356725935',
    '123456',
    1,
    '{"name": "赵小敏", "department": "人工智能工程中心", "office": "B522/B524", "phone_number": "56075072", "email": "zxm@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '秦绪佳',
    '312063249020339',
    '123456',
    1,
    '{"name": "秦绪佳", "department": "数字媒体技术研究所  ", "office": "D533", "phone_number": "", "email": "qxj@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '陈佳舟',
    '384722033933311',
    '123456',
    1,
    '{"name": "陈佳舟", "department": "数字媒体技术研究所", "office": "B506/B508", "phone_number": "85290385", "email": "cjz@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '曹悦',
    '2636124742',
    '123456',
    1,
    '{"name": "曹悦", "department": "数字媒体技术研究所", "office": "", "phone_number": "", "email": "ycao@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '陈志杨',
    '384722453526472',
    '123456',
    1,
    '{"name": "陈志杨", "department": "数字媒体技术研究所", "office": "B506/B508", "phone_number": "85290385", "email": "czy@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '简琤峰',
    '316162973223792',
    '123456',
    1,
    '{"name": "简琤峰", "department": "数字媒体技术研究所", "office": "B506/B508", "phone_number": "85290385", "email": "jiancf@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '马骥',
    '3953239589',
    '123456',
    1,
    '{"name": "马骥", "department": "数字媒体技术研究所", "office": "B506/B508", "phone_number": "85290385", "email": "maji@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '汤颖',
    '2774839062',
    '123456',
    1,
    '{"name": "汤颖", "department": "数字媒体技术研究所", "office": "B506/B508", "phone_number": "85290385", "email": "ytang@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '张繁',
    '2435232321',
    '123456',
    1,
    '{"name": "张繁", "department": "数字媒体技术研究所", "office": "B506/B508", "phone_number": "85290385", "email": "zf@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '张美玉',
    '243523265429577',
    '123456',
    1,
    '{"name": "张美玉", "department": "数字媒体技术研究所", "office": "B506/B508", "phone_number": "85290385", "email": "zmy@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '高飞',
    '3964039134',
    '123456',
    1,
    '{"name": "高飞", "department": "图形图像研究所     ", "office": "B410/B412", "phone_number": "85290535", "email": "feig@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '陈久军',
    '384722003720891',
    '123456',
    1,
    '{"name": "陈久军", "department": "图形图像研究所     ", "office": "B406/B408", "phone_number": "85290535", "email": "rackycjj@zjut.edu.cn ", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '程振波',
    '312432539127874',
    '123456',
    1,
    '{"name": "程振波", "department": "图形图像研究所", "office": "B406/B408", "phone_number": "85290535", "email": "czb@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '翁立波',
    '327053143527874',
    '123456',
    1,
    '{"name": "翁立波", "department": "图形图像研究所", "office": "", "phone_number": "", "email": "wenglibo@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '颜世航',
    '390681999033322',
    '123456',
    1,
    '{"name": "颜世航", "department": "图形图像研究所", "office": "A502", "phone_number": "85290527", "email": "shyan@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '张元鸣',
    '243522080340483',
    '123456',
    1,
    '{"name": "张元鸣", "department": "图形图像研究所", "office": "B406/B408", "phone_number": "85290535", "email": "zym@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '邵奇可',
    '370452285521487',
    '123456',
    1,
    '{"name": "邵奇可", "department": "图形图像研究所     ", "office": "A515", "phone_number": "", "email": "sqk@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '徐雪松',
    '244643863426494',
    '123456',
    1,
    '{"name": "徐雪松", "department": "图形图像研究所（博士后）", "office": "B405", "phone_number": "", "email": "song885280@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '杨旭华',
    '264722609321326',
    '123456',
    1,
    '{"name": "杨旭华", "department": "智能计算研究所", "office": "D521", "phone_number": "85290519", "email": "xhyang@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '徐新黎',
    '244642603240654',
    '123456',
    1,
    '{"name": "徐新黎", "department": "智能计算研究所", "office": "B310/B312", "phone_number": "", "email": "xxl@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '龙海霞',
    '408572802338686',
    '123456',
    1,
    '{"name": "龙海霞", "department": "智能计算研究所", "office": "B318", "phone_number": "", "email": "longhaixia@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '毛剑飞',
    '276112107339134',
    '123456',
    1,
    '{"name": "毛剑飞", "department": "智能计算研究所", "office": "B510/B512", "phone_number": "85290613", "email": "mjf@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '吴福理',
    '215563111929702',
    '123456',
    1,
    '{"name": "吴福理", "department": "智能计算研究所", "office": "B510/B512", "phone_number": "85290613", "email": "fuliwu@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '肖杰',
    '3291826480',
    '123456',
    1,
    '{"name": "肖杰", "department": "智能计算研究所", "office": "D227", "phone_number": "", "email": "xiaojiexqj@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '叶蕾',
    '2149434174',
    '123456',
    1,
    '{"name": "叶蕾", "department": "智能计算研究所", "office": "B510/B512", "phone_number": "85290613", "email": "yelei@zjut.edu.cn ", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '张端',
    '2435231471',
    '123456',
    1,
    '{"name": "张端", "department": "智能计算研究所", "office": "B510/B512", "phone_number": "85290613", "email": "dzhang@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '周艳波',
    '216083339527874',
    '123456',
    1,
    '{"name": "周艳波", "department": "智能计算研究所", "office": "B513/B515", "phone_number": "85290027", "email": "zhyb@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '张宇辰',
    '243522343136784',
    '123456',
    1,
    '{"name": "张宇辰", "department": "智能计算研究所", "office": "", "phone_number": "", "email": "yuczhang9@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '马钢峰',
    '395323805023792',
    '123456',
    1,
    '{"name": "马钢峰", "department": "智能计算研究所（博士后）", "office": "B512", "phone_number": "", "email": "gf_ma@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '杨东勇',
    '264721999621191',
    '123456',
    1,
    '{"name": "杨东勇", "department": "", "office": "", "phone_number": "", "email": "ydy@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '徐卫',
    '2446421355',
    '123456',
    1,
    '{"name": "徐卫", "department": "实验中心", "office": "健B213", "phone_number": "85290088", "email": "xw@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '叶阳',
    '2149438451',
    '123456',
    1,
    '{"name": "叶阳", "department": "实验中心软件实验室", "office": "计-B204", "phone_number": "85290038", "email": "yeyang80@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '顾国民',
    '390382226927665',
    '123456',
    1,
    '{"name": "顾国民", "department": "实验中心软件实验室", "office": "计-B206", "phone_number": "87357732", "email": "ggm@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '侯向辉',
    '203992152136745',
    '123456',
    1,
    '{"name": "侯向辉", "department": "实验中心软件实验室", "office": "计-B206", "phone_number": "85290042", "email": "hxh@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '王小号',
    '295792356721495',
    '123456',
    1,
    '{"name": "王小号", "department": "实验中心软件实验室", "office": "计-B204", "phone_number": "85290138", "email": "wxh@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '黄重水',
    '406443732527700',
    '123456',
    1,
    '{"name": "黄重水", "department": "实验中心软件实验室", "office": "计-B109", "phone_number": "85290509", "email": "hzs@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '陈琦',
    '3847229734',
    '123456',
    1,
    '{"name": "陈琦", "department": "实验中心系统实验室", "office": "计-B109", "phone_number": "85290509", "email": "chenqi@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '刘邦明',
    '210163703026126',
    '123456',
    1,
    '{"name": "刘邦明", "department": "实验中心系统实验室", "office": "计-B109", "phone_number": "85290509", "email": "liubmhz@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '金亦挺',
    '373292013425402',
    '123456',
    1,
    '{"name": "金亦挺", "department": "实验中心可视媒体重点实验室", "office": "计-A112", "phone_number": "85290675", "email": "jytzjut@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '潘企弘',
    '285042022524344',
    '123456',
    1,
    '{"name": "潘企弘", "department": "实验中心系统实验室", "office": "", "phone_number": "", "email": "panchenji66@qq.com", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '劳洁莹',
    '211712790533721',
    '123456',
    1,
    '{"name": "劳洁莹", "department": "实验中心中心实验室", "office": "", "phone_number": "", "email": "ljy@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '叶青',
    '2149438738',
    '123456',
    1,
    '{"name": "叶青", "department": "实验中心中心实验室", "office": "健B212", "phone_number": "85290086", "email": "yq@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '刘文捷',
    '210162599125463',
    '123456',
    1,
    '{"name": "刘文捷", "department": "实验中心中心实验室", "office": "健B212", "phone_number": "85290086", "email": "lwj@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '卢瑾',
    '2134629822',
    '123456',
    1,
    '{"name": "卢瑾", "department": "实验中心中心实验室", "office": "健B212", "phone_number": "85290086", "email": "lujin@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '孙志磊',
    '233852453530922',
    '123456',
    1,
    '{"name": "孙志磊", "department": "实验中心中心实验室", "office": "健B212", "phone_number": "85290086", "email": "szl@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '秦娥',
    '3120623077',
    '123456',
    1,
    '{"name": "秦娥", "department": "实验中心中心实验室", "office": "新教楼1109", "phone_number": "88320046", "email": "qe@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '樊潮',
    '2714628526',
    '123456',
    1,
    '{"name": "樊潮", "department": "实验中心中心实验室", "office": "新教楼1013", "phone_number": "88320361", "email": "fc@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '韩映丽',
    '388892614420029',
    '123456',
    1,
    '{"name": "韩映丽", "department": "实验中心中心实验室", "office": "新教楼1013", "phone_number": "88320361", "email": "hanyl@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '郑劼',
    '3707321180',
    '123456',
    1,
    '{"name": "郑劼", "department": "实验中心中心实验室", "office": "新教楼1013", "phone_number": "88320361", "email": "zjie@zjut.edu.cn", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '田小凤',
    '300002356720964',
    '123456',
    1,
    '{"name": "田小凤", "department": "实验中心中心实验室", "office": "莫干山校区", "phone_number": "", "email": "717367013@qq.com", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    'admin',
    'admin',
    '123456',
    2,
    '{"name": "admin", "time": "12:00:00-13:00:00,2:00:00-3:00:00"}',
    null
);
