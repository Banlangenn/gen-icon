# gen-icon

> 阿里巴巴矢量图标库自动生前端css文件
## Installation

```bash
$ npm install  gen-icon --dev
$ yarn add  gen-icon --dev
```
（mac 遇到权限问题,在安装命令前加  sudo 即可）

* 建议：直接使用npx @banlangen/gen-icon 无需安装
# explain
依赖: 
- [@antmjs/iconfont](https://www.npmjs.com/package/@antmjs/iconfont)
## Example usage:

> 安装
```bash
$ npx gen-icon --input-path https://at.alicdn.com/t/xxxxxxx.css --output-path src/iconfont.less
```
> 不安装
```bash
$ npx @banlangen/gen-icon  --input-path https://at.alicdn.com/t/xxxxxxx.css --output-path src/iconfont.less  --input-cookie EGG_SESS_ICONFONT=U8AXvqwxxxless
```
竟然差不多~沃日， 所以推荐不安装(--input-cookie 必填)
## API

支持两种模式
### 一. 图标更新，需要更新--input-path 

|   Option               |      Description           |  Required     | Default value              |
| :---------------------: | :-------------------------: | :------------: | :-------------------------: |
| npx gen-icon              | 命令主体 | true | N/A |
| --output-path           | 输出文件路径(路径的上的文件夹必须存在) |true	| N/A |
| --input-path            | 输入URL，[阿里巴巴矢量图标库](https://www.iconfont.cn/)项目的css文件url |true	| N/A  |


### 二. 图标更新，bu需要更新--input-path 

|   Option               |      Description           |  Required     | Default value              |
| :---------------------: | :-------------------------: | :------------: | :-------------------------: |
| @banlangen/gen-icon             | 命令主体 | true | N/A |
| --output-path           | 输出文件路径(路径的上的文件夹必须存在) | true	| N/A |
| --input-path            | 输入URL，[阿里巴巴矢量图标库](https://www.iconfont.cn/)项目的文件下载url |true	| N/A  |
| --input-cookie          | 鉴权cookie, [阿里巴巴矢量图标库](https://www.iconfont.cn/)项目的用户标识cookie |true	| N/A |



