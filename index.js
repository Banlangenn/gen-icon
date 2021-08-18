#!/usr/bin/env node
const childProcess = require('child_process')
const {resolve} = require('path')
let input,output,cookie;

process.argv.forEach((val, index) => {
    if (val === '--input-path') {
      input = process.argv[index + 1]
    }
    if (val === '--input-cookie') {
        cookie = process.argv[index + 1]
      }
    if (val === '--output-path') {
      output = process.argv[index + 1]
    }
})

if (input && output) {
    if (cookie) {
        
        const shellFile = resolve(__dirname, './iconfont.sh')
        // console.log(shellFile)
        const cmd = `${shellFile} ${input} ${output} ${cookie}`
        childProcess.exec(cmd, function(error, stdout, stderr) {
            if (error) {
                console.log("error:"+error)
            }
            console.log(stdout)
            // console.log("stderr:"+stderr)
        })
        return
    }
    const cmd = `npx @antmjs/iconfont --input-path ${input} --output-path ${output}`
    childProcess.exec(cmd, function(error, stdout, stderr) {
        if (error) {
            console.log("error:"+error)
        }
        console.log(stdout)
        // console.log("stderr:"+stderr)
    });
  } else {
    console.error(
      '参数错误',
      'npx gen-icon --input-path https://at.alicdn.com/t/xxxxxxx.css --output-path src/iconfont.less  --input-cookie EGG_SESS_ICONFONT=U8AXvqwxxx',
    )
  }