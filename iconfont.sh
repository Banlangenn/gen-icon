#!/bin/bash

# URL="https://www.iconfont.cn/api/project/download.zip?pid=2499717"
# COOKIE="EGG_SESS_ICONFONT=U8AXvqwdm-42-umGXGwgKq_Emj2wuVCkA87TjZ3dn6xm2T4whio3sIKoy4kjkuBSusLMQ-0MhcjWBE1FwhfGmMbpO9xPCEANAHIhoET_7kJ_pbscGV6FmfCh8QTWcmCiTv5lhhXEW-AxLfe1otCy-eI-zPgODc0D5EZxlVSk4mqOdEz-94IZi5OAcsu3pRkTAQs9KRTgwyfMtp67P9YXwDeVNoXPHTR1XHpaQgBHgWZxIoXczyxCXVtKz5kL3XUgvwp6JLe2wev9xkYzghiHal_l2O_PcxZeT4vkTPq-vtmecCuam6i0OeusdHZNEIUuEm8-xQ1Gp1-3uz-ohjM4EgI2FIJPLQXNch_Jf8eqSvypZ8qrOn75i0U5I-oCQqRVRDKXGZFKiddDNSSjhFg18BqFLdysnN3DmcYoeHfu6roVkd1ea3Wd_KeT1uVynmF8l4MC23DX1CbwrkuLROGOS-RI5P5UiknOESYiVlAjEZsgBf7iHKOuvoctaCOUVTmGL2Q_jn7RbNSH2tuX_Qg0EuOiFVJ0dRC9y7Elbz2Nu4XiuzKxNv7uiowuhbLjckoTM0Z1rtIRI-efNpyo9ujMJ78dSobqPKm5hb6koojumtyD1tCYVRfeCo1pEid3bcTqqHEU0FAXQNjOV6U_qzH8DqJkCqjJv7km9bzlMSg9r0hVw7T4pXlwXF3Xn-cX_B938IKt0wr3XDbqFPaI0AILxZCmAArqYbcbFs1l-FoAudmJ889aYQmRMe3r3LNjznoqEu1vthbgOqJ1ycmFu6PpArVSdjPmYizaWusLkzWjXQyTjAbGlhwr1hBf5w_iYTFsAGO8p9K5VEmXJUG3QF51t0IXqnGJyAYfzAXCv4U0DAavaXQpAUwPgt-FB17adSbLRim0SDoBh9spvxXro4INUwgkcd11-SwXhS6BAeLNVUqrfOhRrMIo-8gUR2hUIp-31FQj92VpMIzcfJ0DCbO1DQZHDQBlMZok5xlSapcikVQeVPwOmP1AACN9K3RQ5gmb0QJoZc8t788wKIZQpxmcYXwpya7s3llZZ05C-7-dCPF18l910QlJgOPRkreoLCFg"
# outputPath="iconfont.less"


URL=$1
outputPath=$2
COOKIE=$3

# echo ${URL}
# echo ${COOKIE}
# echo ${outputPath}

FIlENAME="download"
unzip_name="./${FIlENAME}.zip"
rename=$FIlENAME

echo "start..."

if [ -f $unzip_name ];then
 rm -f $unzip_name
fi

# 下载文件

curl -s -o  $unzip_name $URL \
  -H 'authority: www.iconfont.cn' \
  -H 'sec-ch-ua: "Chromium";v="92", " Not A;Brand";v="99", "Google Chrome";v="92"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36' \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-fetch-mode: navigate' \
  -H 'sec-fetch-user: ?1' \
  -H 'sec-fetch-dest: document' \
  -H 'referer: https://www.iconfont.cn/manage/index?spm=a313x.7781069.1998910419.13&manage_type=myprojects&projectId=798824&keyword=&project_type=&page=' \
  -H 'accept-language: zh-CN,zh;q=0.9' \
  -H "cookie:${COOKIE}" \
  -H 'if-none-match: W/"5214-17ae7641077"' \
  -H 'if-modified-since: Tue, 27 Jul 2021 09:55:32 GMT' \


if [ -d $rename ];then
  rm -r -f $rename
fi

zipContent=$(cat $unzip_name)

code=$(echo $zipContent | grep -Eo "\d+")

# 读取下来如果是个json  就告知失败
if [[ $code == "500" ]];then
  echo 'download fail'
  exit 0
fi
 

# 把文件 解压到  rname 文件夹内
unzip -jq $unzip_name  -d $rename

# 转base64
base64File=$(base64 ./$rename/iconfont.ttf)

echo "generate file ..."

# 读取css
iconCss=$(cat ./$rename/iconfont.css )

fontFamily=$(echo $iconCss | grep -Eo "font-family:\s+[\"\']\w+[\"\'];")

font="@font-face {${fontFamily} src: url(data:font/truetype;charset=utf-8;base64,${base64File})  format('truetype');font-weight: normal;font-style: normal;}"

iconfont=$(echo $iconCss | grep -Eo '\.\w+\s+\{.*}\s*$')


if [ -f $outputPath ];then
  rm  -f $outputPath
fi

# 创建文件
touch $outputPath


# 写入文件
cat >>$outputPath<<EOF
/*
  该文件为脚本自动写入,请不要修改
  date: $(date "+%Y-%m-%d %H:%M:%S")
*/

$font


$iconfont

EOF

# 删除原始zip文件
# rm -f $unzip_name

echo "end ..."

# 删除文件以及解压文件
rm -f $unzip_name
rm -r -f $rename


#  ./iconfont.sh  https://www.iconfont.cn/api/project/download.zip?pid=2499717 EGG_SESS_ICONFONT=U8AXvqwdm-42-umGXGwgKq_Emj2wuVCkA87TjZ3dn6xm2T4whio3sIKoy4kjkuBSusLMQ-0MhcjWBE1FwhfGmMbpO9xPCEANAHIhoET_7kJ_pbscGV6FmfCh8QTWcmCiTv5lhhXEW-AxLfe1otCy-eI-zPgODc0D5EZxlVSk4mqOdEz-94IZi5OAcsu3pRkTAQs9KRTgwyfMtp67P9YXwDeVNoXPHTR1XHpaQgBHgWZxIoXczyxCXVtKz5kL3XUgvwp6JLe2wev9xkYzghiHal_l2O_PcxZeT4vkTPq-vtmecCuam6i0OeusdHZNEIUuEm8-xQ1Gp1-3uz-ohjM4EgI2FIJPLQXNch_Jf8eqSvypZ8qrOn75i0U5I-oCQqRVRDKXGZFKiddDNSSjhFg18BqFLdysnN3DmcYoeHfu6roVkd1ea3Wd_KeT1uVynmF8l4MC23DX1CbwrkuLROGOS-RI5P5UiknOESYiVlAjEZsgBf7iHKOuvoctaCOUVTmGL2Q_jn7RbNSH2tuX_Qg0EuOiFVJ0dRC9y7Elbz2Nu4XiuzKxNv7uiowuhbLjckoTM0Z1rtIRI-efNpyo9ujMJ78dSobqPKm5hb6koojumtyD1tCYVRfeCo1pEid3bcTqqHEU0FAXQNjOV6U_qzH8DqJkCqjJv7km9bzlMSg9r0hVw7T4pXlwXF3Xn-cX_B938IKt0wr3XDbqFPaI0AILxZCmAArqYbcbFs1l-FoAudmJ889aYQmRMe3r3LNjznoqEu1vthbgOqJ1ycmFu6PpArVSdjPmYizaWusLkzWjXQyTjAbGlhwr1hBf5w_iYTFsAGO8p9K5VEmXJUG3QF51t0IXqnGJyAYfzAXCv4U0DAavaXQpAUwPgt-FB17adSbLRim0SDoBh9spvxXro4INUwgkcd11-SwXhS6BAeLNVUqrfOhRrMIo-8gUR2hUIp-31FQj92VpMIzcfJ0DCbO1DQZHDQBlMZok5xlSapcikVQeVPwOmP1AACN9K3RQ5gmb0QJoZc8t788wKIZQpxmcYXwpya7s3llZZ05C-7-dCPF18l910QlJgOPRkreoLCFg ./iconfont.less