# CC Switch iOS 安装指南

## 准备工作

你需要的文件：`CC_Switch_iOS.ipa`（位于 `dist/` 目录下）

---

## 方法一：TestFlight 官方分发（推荐 ⭐）

### 是什么

Apple 官方提供的 Beta 测试分发平台。你把 App 上传到 App Store Connect，用户通过 TestFlight App 一键安装。这是所有正规 App 发布前的标准测试流程。

### 条件

- Apple Developer Program 付费账号（$99/年，约 ¥688）
- 或者被邀请加入别人的开发者团队（Team 中的 Admin 或 Developer 角色）

### 开发者操作步骤

#### 第一步：注册 Apple Developer 账号

1. 打开浏览器访问 [developer.apple.com](https://developer.apple.com)
2. 点击右上角 **Account** → 用你的 Apple ID 登录
3. 登录后点击 **Enroll**（如果尚未注册开发者计划）
4. 选择账号类型：
   - **Individual**（个人）：只需要你的姓名和 Apple ID，审核快（通常 24 小时内）
   - **Organization**（组织）：需要公司营业执照和 D-U-N-S 编码，审核慢（1-2 周）
5. 支付 **$99/年**（约 ¥688）
6. 等待激活邮件（通常 1-2 天），收到后开发者账号即生效

#### 第二步：配置 Xcode 签名

1. 打开终端，进入项目目录：
   ```bash
   cd "/Users/martin/Desktop/CC Switch"
   open ios/Runner.xcworkspace
   ```
2. Xcode 打开后，左侧文件列表点击 **Runner** 项目
3. 中间选择 **Runner** target → **Signing & Capabilities** 标签
4. 勾选 **Automatically manage signing**
5. **Team** 下拉选择你的开发者账号（例如：`Chen Martin (BU89V345NK)`）
6. Bundle Identifier 确认是 `com.ccswitch.ccSwitch`

#### 第三步：在 App Store Connect 创建 App

1. 打开 [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
2. 点击 **我的 App**（My Apps）→ 左上角 **＋** → **新建 App**
3. 填写以下信息：
   - **平台**：iOS
   - **名称**：CC Switch
   - **主要语言**：Simplified Chinese（或你需要的语言）
   - **套装 ID**：选择 `com.ccswitch.ccSwitch`（如果在列表中没有，需要先去 developer.apple.com → Certificates, Identifiers & Profiles → Identifiers 注册 Bundle ID）
   - **SKU**：任意唯一字符串，例如 `ccswitch001`
   - **用户访问权限**：完全访问
4. 点击 **创建**

#### 第四步：Archive 并上传

1. 在 Xcode 中，顶部设备选择器改为 **Any iOS Device (arm64)**
2. 菜单栏：**Product** → **Archive**
3. 等待编译完成（可能需要几分钟），**Organizer** 窗口会自动弹出
4. 在 Organizer 中，选中刚生成的 Archive → 点击右侧 **Distribute App**
5. 选择 **App Store Connect** → Next
6. 选择 **Upload** → Next
7. 保持默认选项 → Next
8. 选择自动管理签名 → Next
9. 点击 **Upload**，等待上传完成
10. 上传成功后，**App Store Connect 不会立刻显示**，需要等待 Apple 处理（通常几分钟到半小时）

#### 第五步：配置 TestFlight

1. 回到 [App Store Connect](https://appstoreconnect.apple.com)
2. 进入你的 App → **TestFlight** 标签
3. 你会看到刚上传的构建版本（Build），状态可能是「正在处理」
4. 等状态变成「就绪」（Ready to Submit），然后点击构建版本号
5. 填写「测试内容」（What to Test）—— 告诉测试员这个版本有什么新内容
6. 如果有出口合规问题，按实际情况回答（一般选「否」）
7. 点击 **提交审核**（TestFlight 的审核不同于 App Store 审核，通常只需几小时，首次可能 1-2 天）

#### 第六步：邀请测试员

**方式 A — 通过邮箱邀请（适合内部团队，最多 100 人）：**
1. TestFlight 页面 → **App Store Connect 用户** 或 **内部测试员**
2. 在 App Store Connect → **用户和访问** 中添加团队成员
3. 或者点 **外部测试员** → **＋** → 输入邮箱地址
4. 用户会收到邮件邀请，接受后即可安装

**方式 B — 公开链接（适合大规模分发，最多 10,000 人）：**
1. TestFlight 页面 → **外部测试** → 找到「公开链接」
2. 点击 **启用公开链接**
3. 设置测试员上限（默认 10,000）
4. 复制生成的公开链接，格式类似：
   ```
   https://testflight.apple.com/join/XXXXXXXX
   ```
5. 把这个链接发给任何人，他们点击即可安装

### 用户安装流程

1. 在 iPhone 上打开 App Store，搜索并下载 **TestFlight**（Apple 官方 App）
2. 打开你发的 TestFlight 公开链接（或邮件邀请）
3. TestFlight 自动打开，显示 CC Switch 的信息
4. 点击 **安装**（Install）
5. App 下载并安装到主屏幕
6. 之后每次 App 有新版本，TestFlight 会自动推送更新通知

### 注意事项

- **构建版本有效期**：上传后 90 天内有效，90 天后需要上传新版本
- **App 有效期**：用户安装的 App 在 90 天后会过期，需要更新版本
- **审核豁免**：TestFlight 首次构建需要审核，但同一版本号的后续构建通常可以跳过审核
- **最多 10,000 名外部测试员**
- **App Store 正式上架时需要重新审核**，审核标准比 TestFlight 严格

---

## 方法二：AltStore —— 免费且自动续签

### 是什么

AltStore 是一个利用 Apple 免费开发者签名机制（侧载）的 App Store 替代品。它运行在你的电脑上作为 AltServer，在 iPhone 上安装 AltStore App，然后用你自己的 Apple ID 给任意 IPA 签名安装。特别之处在于 **它能自动续签**，不需要每 7 天重新插线安装。

### 条件

- 一台 Mac（macOS 12+）或 Windows PC（Windows 10+）
- 任意 Apple ID（免费即可，建议用专门注册的小号）
- iPhone 和电脑在同一 WiFi 网络下（自动续签时需要）
- iPhone iOS 14+

### 用户操作步骤（发给用户的教程）

#### 第一步：在电脑上安装 AltServer

1. 访问 [altstore.io](https://altstore.io) 下载
2. **Mac 用户**：
   - 下载 `.dmg` 文件，打开后将 AltServer 拖到 Applications 文件夹
   - 首次打开 AltServer：系统偏好设置可能提示「无法验证开发者」
   - 去 **系统设置 → 隐私与安全性 → 仍要打开**
   - 或者右键 AltServer → 按住 Option → 打开
   - AltServer 启动后，**菜单栏右上角会出现一个菱形图标 ◇**
3. **Windows 用户**：
   - 下载 `.msi` 安装包，双击安装
   - 需要安装 **iTunes** 和 **iCloud**（从 Apple 官网下载，不要从 Microsoft Store）
   - AltServer 启动后，**系统托盘出现菱形图标 ◇**

#### 第二步：在 iPhone 上安装 AltStore

1. 用 **数据线**（原装或 MFi 认证）连接 iPhone 到电脑
2. **解锁 iPhone**，如果是第一次连接，点「**信任此电脑**」→ 输入锁屏密码确认
3. 在电脑上点击 AltServer 图标 ◇
4. 菜单中选 **Install AltStore** → 选择你的 iPhone 名称
5. 弹出窗口让你输入 **Apple ID 和密码**：
   - ⚠️ **重要**：建议使用一个专门的小号 Apple ID，不要用主力账号
   - 如果开启了两步验证，需要生成 App-Specific Password：
     - 登录 [appleid.apple.com](https://appleid.apple.com)
     - 登录与安全性 → App 专用密码 → 生成 → 复制密码
     - 在 AltServer 中输入这个 App 专用密码
6. 等待几分钟，AltStore 图标会出现在 iPhone 主屏幕上
7. **如果 AltStore 打不开**（闪退或提示「不受信任的开发者」）：
   - iPhone：**设置 → 通用 → VPN 与设备管理**
   - 找到你的 Apple ID 邮箱 → 点击 **信任**
   - 返回主屏幕，AltStore 就可以打开了

#### 第三步：安装 CC Switch

**方式 A — 用 AirDrop（最方便）：**
1. Mac 上选中 `CC_Switch_iOS.ipa` → 右键 → 共享 → AirDrop → 选你的 iPhone
2. iPhone 接收后，在「文件」App 中找到 `.ipa` 文件
3. 长按文件 → **共享** → 在 App 列表中找到 **AltStore**
4. AltStore 自动打开 → 开始签名 → 几秒后 CC Switch 出现在主屏幕

**方式 B — 用 iCloud 文件：**
1. 把 `.ipa` 放到 iCloud Drive
2. iPhone 上打开「文件」App → iCloud Drive
3. 找到 `.ipa` → 分享 → AltStore

**方式 C — 从 AltStore 内直接安装：**
1. 在 iPhone 上打开 AltStore
2. 底部切换到 **My Apps** 标签
3. 点左上角 **＋**
4. 浏览找到 `.ipa` 文件 → 选择

#### 第四步：设置自动续签

免费 Apple ID 签名的 App 只有 7 天有效期，但 AltStore 可以自动续签：

1. **电脑上 AltServer 保持开机运行**（菜单栏有 ◇ 图标）
2. **iPhone 和电脑连在同一个 WiFi**
3. **iPhone 上 AltStore 在后台运行**（不要手动划掉）
4. 到期前 1-2 天，AltStore 会自动在后台重新签名
5. 也可以在 iPhone 上手动打开 AltStore → **My Apps** → 点 **Refresh All**

⚠️ 如果 iPhone 超过 7 天没和电脑在同一 WiFi，签名会过期，App 打不开。这时重新连 WiFi 再手动 Refresh 即可恢复。

### 调试常见问题

| 问题 | 解决方法 |
|------|----------|
| AltServer 找不到 iPhone | 换 USB 口、换线、确保 iPhone 解锁并信任 |
| 安装失败 | 检查 iPhone 设置 → 通用 → VPN 与设备管理 → 信任证书 |
| 续签失败 | 确保 AltServer 在电脑运行 + 同 WiFi + iPhone 解锁 |
| 提示「不再可用」 | 打开 AltStore 手动 Refresh All |
| AltStore 闪退 | iOS 重启后需要重新信任证书（设置 → 通用 → VPN 与设备管理） |

---

## 方法三：Sideloadly —— 最简单，拖拽即装

### 是什么

Sideloadly 是一个给 IPA 签名的桌面工具，拖拽 IPA 进去，输入 Apple ID，自动签名 + 安装到 iPhone。操作极其简单，不需要在 iPhone 上装任何额外的 App。

### 条件

- Mac（macOS 10.12+）或 Windows（Windows 7+）
- 任意 Apple ID（免费即可）
- 数据线连接 iPhone

### 用户操作步骤

#### 第一步：下载安装 Sideloadly

1. 访问 [sideloadly.io](https://sideloadly.io)
2. 下载对应平台版本（Mac 或 Windows）
3. 安装并打开 Sideloadly

#### 第二步：签名并安装

1. 用数据线连接 iPhone 到电脑
2. 解锁 iPhone，点「信任此电脑」
3. 打开 Sideloadly，界面很简单，主要就三个区域：
   - 顶部大框：**拖拽 IPA 文件到这里**（把 `CC_Switch_iOS.ipa` 拖进去）
   - Apple ID 栏：输入你的 Apple ID（建议用小号）
   - 设备栏：自动识别你连接的 iPhone
4. 高级选项（通常不需要改）：
   - **Sign with Sideloadly**：默认就行
   - **Auto-Refresh**：勾选后可以让 App 在后台自动续签（需要电脑一直开着 Sideloadly）
   - **Inject Cydia Substrate**：不要勾选
5. 点击 **Start** 按钮
6. 如果是第一次使用，会提示输入 Apple ID 密码（或 App-Specific Password）
7. 等待进度条走完，App 就会出现在 iPhone 主屏幕上

#### 第三步：信任证书

如果是第一次用这个 Apple ID 签名，iPhone 上需要：

1. **设置 → 通用 → VPN 与设备管理**
2. 在「开发者 App」下找到你的 Apple ID
3. 点击 **信任「你的 Apple ID」**
4. 弹出确认对话框 → 点 **信任**
5. 返回主屏幕，App 就可以打开了

#### 第四步：续签

- **不勾选 Auto-Refresh**：每 7 天需要重新用 Sideloadly 装一次（再拖一次 IPA → Start）
- **勾选 Auto-Refresh**：Sideloadly 在电脑上开着，到期前自动刷新签名（仍需同 WiFi）

#### 与 AltStore 的区别

| 对比 | Sideloadly | AltStore |
|------|-----------|----------|
| 操作 | 拖 IPA → Start | 需要先在手机装 AltStore |
| 续签 | 需要重新连接电脑 | WiFi 自动续签 |
| iPhone 上安装 | 不需要装额外 App | 需要装 AltStore App |
| 适合 | 偶尔用、给朋友装 | 长期用、多个 IPA |

---

## 方法四：企业证书分发 —— 无需 UDID，Safari 一键安装

### 是什么

Apple Developer Enterprise Program 允许企业将内部 App 直接分发到员工设备上，不需要经过 App Store，不需要注册 UDID，不需要 TestFlight。用户只需在 Safari 中点一个链接就能安装。**这是自由度和体验最高的分发方式，也是最贵的。**

### 条件

- **Apple Developer Enterprise Program 账号**（$299/年，约 ¥2,068）
- 公司必须有合法的 **D-U-N-S 编号**（邓白氏编码）
- 一个支持 **HTTPS** 的服务器（用于托管 IPA 和 Manifest plist）
- 公司营业执照（用于身份验证）

### 开发者操作步骤

#### 第一步：申请企业开发者账号

1. 访问 [developer.apple.com/programs/enterprise](https://developer.apple.com/programs/enterprise)
2. 点击 **Start Your Enrollment**
3. 需要准备：
   - **Apple ID**（建议用公司邮箱新注册）
   - **D-U-N-S 编码**：如果没有，可以在申请页面免费获取（通常需要 5-14 个工作日）
   - **公司营业执照**
   - **公司联系人信息**（需与 D-U-N-S 信息一致）
4. Apple 会打电话到公司验证（通常是前台或法人电话）
5. 审核通过后支付 **$299/年**
6. 全部流程通常需要 **1-3 周**

#### 第二步：创建企业分发证书

1. 登录 [developer.apple.com](https://developer.apple.com)
2. **Account** → **Certificates, Identifiers & Profiles**
3. **Certificates** → **＋** → 选择 **iOS Distribution (Enterprise)**
4. 按指引生成 CSR 文件（钥匙串访问 → 证书助理 → 从证书颁发机构请求证书）
5. 上传 CSR → 下载生成的 `.cer` 证书文件
6. 双击 `.cer` 安装到钥匙串

#### 第三步：注册 Bundle ID 和 Provisioning Profile

1. **Identifiers** → **＋** → **App IDs**
2. Bundle ID 选择 **Explicit** → 输入 `com.ccswitch.ccSwitch`
3. 勾选需要的 Capabilities（通常默认即可）
4. 回到 **Profiles** → **＋** → **In House**
5. 选择刚创建的 App ID → 选择企业分发证书 → 命名 → 下载 `.mobileprovision`

#### 第四步：用企业证书签名 IPA

**在 Mac 上重新签名现有的 IPA：**

```bash
# 解压现有 IPA
cd "/Users/martin/Desktop/CC Switch"
mkdir -p dist/enterprise_sign && cd dist/enterprise_sign
unzip ../CC_Switch_iOS.ipa -d extracted
cd extracted/Payload

# 复制新的 provisioning profile
cp ~/Downloads/CC_Switch_Enterprise.mobileprovision Runner.app/embedded.mobileprovision

# 修改 entitlements（提取原 entitlements）
codesign -d --entitlements :- Runner.app > entitlements.plist 2>/dev/null

# 重新签名（先签 Frameworks，再签主 App）
codesign -f -s "iPhone Distribution: Your Company Name" \
  Runner.app/Frameworks/*.framework
codesign -f -s "iPhone Distribution: Your Company Name" \
  --entitlements entitlements.plist Runner.app

# 重新打包
cd ..
zip -r ../../CC_Switch_Enterprise.ipa Payload
cd ../..
rm -rf extracted
```

> 或者直接在 Xcode 中切换 Provisioning Profile，重新 Archive。

#### 第五步：创建 Manifest plist

创建一个 XML 文件 `manifest.plist`（这是 OTA 安装的关键）：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>items</key>
    <array>
        <dict>
            <key>assets</key>
            <array>
                <dict>
                    <key>kind</key>
                    <string>software-package</string>
                    <key>url</key>
                    <string>https://your-server.com/ipa/CC_Switch.ipa</string>
                </dict>
                <dict>
                    <key>kind</key>
                    <string>display-image</string>
                    <key>url</key>
                    <string>https://your-server.com/ipa/icon_57.png</string>
                </dict>
                <dict>
                    <key>kind</key>
                    <string>full-size-image</string>
                    <key>url</key>
                    <string>https://your-server.com/ipa/icon_512.png</string>
                </dict>
            </array>
            <key>metadata</key>
            <dict>
                <key>bundle-identifier</key>
                <string>com.ccswitch.ccSwitch</string>
                <key>bundle-version</key>
                <string>1.0.0</string>
                <key>kind</key>
                <string>software</string>
                <key>title</key>
                <string>CC Switch</string>
                <key>subtitle</key>
                <string>Hello World App</string>
            </dict>
        </dict>
    </array>
</dict>
</plist>
```

> ⚠️ `display-image`（57×57）和 `full-size-image`（512×512）是可选但推荐的，用来在安装弹窗中显示 App 图标。没有的话安装也能进行。

#### 第六步：上传到 HTTPS 服务器

**必须是 HTTPS，不支持 HTTP。**

你可以用以下任一方式托管：

1. **GitHub Pages**（免费，自动 HTTPS）：
   ```bash
   git clone https://github.com/你的账号/你的账号.github.io.git
   cd 你的账号.github.io
   cp /path/to/manifest.plist .
   cp /path/to/CC_Switch.ipa .
   git add . && git commit -m "Add CC Switch" && git push
   ```
   文件地址类似：`https://你的账号.github.io/CC_Switch.ipa`

2. **阿里云 OSS / 腾讯云 COS + CDN**（推荐，国内速度快）

3. **自己的服务器**（Nginx + Let's Encrypt）：
   ```nginx
   server {
       listen 443 ssl;
       server_name your-server.com;
       ssl_certificate /path/to/cert.pem;
       ssl_certificate_key /path/to/key.pem;
       location /ipa/ {
           root /var/www;
           add_header Content-Disposition attachment;
       }
   }
   ```

#### 第七步：生成安装链接

安装链接格式：

```
itms-services://?action=download-manifest&url=https://your-server.com/manifest.plist
```

你可以把这个链接嵌入到 HTML 页面中：

```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>CC Switch - 下载</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body { font-family: -apple-system; text-align: center; padding: 50px 20px; }
        .btn { display: inline-block; padding: 16px 40px; background: #6366F1;
               color: #fff; border-radius: 12px; text-decoration: none; font-size: 18px; }
    </style>
</head>
<body>
    <h1>CC Switch</h1>
    <p>点击下方按钮安装</p>
    <a class="btn" href="itms-services://?action=download-manifest&url=https://your-server.com/manifest.plist">
        安装 CC Switch
    </a>
    <p style="margin-top: 20px; color: #888;">
        安装后请到：设置 → 通用 → VPN 与设备管理 → 信任企业证书
    </p>
</body>
</html>
```

### 用户安装流程

1. 在 iPhone 上打开 **Safari**（不能用微信内嵌浏览器）
2. 访问你提供的安装页面 URL
3. 点击 **安装 CC Switch** 按钮
4. Safari 弹出对话框：「itms-services 想要安装 CC Switch」→ 点 **安装**
5. 返回主屏幕，App 图标出现 + 进度条
6. 安装完成后，**第一次打开前**需要：
   - **设置 → 通用 → VPN 与设备管理**
   - 在企业级应用下找到 **你的公司名称**
   - 点击 **信任「公司名」**
   - 确认信任
7. 返回主屏幕，App 可以正常打开了

### 注意事项

- **证书可能被 Apple 吊销**：如果滥用（如公开分发到 App Store 已有类别的 App），Apple 会吊销企业证书，导致所有已安装 App 无法打开
- **HTTPS 是必须的**：HTTP 链接无法触发安装
- **plist 的 MIME type** 必须是 `application/xml`
- **.ipa 的 MIME type** 建议设为 `application/octet-stream`

---

## 方法五：Ad Hoc + OTA 分发 —— 付费账号的灵活方案

### 是什么

Apple Developer Program（$99/年）提供「Ad Hoc」分发方式。你需要收集每台设备的 UDID 注册到你的开发者账号中（最多 100 台 iPhone），然后用 Ad Hoc Provisioning Profile 签名。签名后的 IPA 可以通过 OTA（Over The Air）方式分发，用户点链接安装。

**和企业证书的关键区别**：需要 UDID，最多 100 台设备。

### 条件

- Apple Developer Program（$99/年）
- 每台目标设备的 **UDID**（唯一设备标识符）
- HTTPS 服务器（和方案四相同）

### 开发者操作步骤

#### 第一步：帮助用户获取 UDID

给用户以下两种获取 UDID 的方法：

**方法 A：用 udid.io 在线获取（推荐，不需要电脑）**

1. iPhone 上打开 **Safari**，访问 [get.udid.io](https://get.udid.io)
2. 点击 **获取 UDID** 或 **Tap to Find UDID**
3. 弹出「此网站正尝试下载一个配置描述文件」→ 点 **允许**
4. 去 **设置 → 通用 → VPN 与设备管理**（iOS 17+ 在 设置 → 通用 → 设备管理中）
5. 点击刚下载的配置文件 → **安装** → 输入锁屏密码
6. 安装后 Safari 自动跳转，页面显示 UDID 和设备信息
7. UDID 是一串 40 个字符的十六进制字符串，类似：`00008130-001414EE0E52001C`
8. 把 UDID 发给你
9. 回到 **设置 → 通用 → VPN 与设备管理** → 删除刚安装的配置文件（可选）

**方法 B：用 Mac 获取**

1. 数据线连接 iPhone 到 Mac
2. 打开 **Finder**
3. 左侧边栏点击你的 iPhone
4. 在 iPhone 信息面板中，点击「序列号」这几个字
5. 显示切换为「UDID」
6. 右键 → **复制 UDID**
7. 发给你

**方法 C：用 Xcode 获取**

1. 数据线连接 iPhone 到 Mac
2. 打开 Xcode → **Window → Devices and Simulators**
3. 左侧选择你的 iPhone
4. **Identifier** 字段就是 UDID，复制即可

#### 第二步：在开发者后台注册设备

1. 登录 [developer.apple.com](https://developer.apple.com) → Account
2. **Certificates, Identifiers & Profiles**
3. 左侧点 **Devices**
4. 点击 **＋** 按钮
5. **Platform**：iOS
6. **Device Name**：给设备起个名字，比如「张三的 iPhone 15」「我的 iPad Pro」方便管理
7. **Device UDID**：粘贴用户发给你的 UDID
8. 点击 **Continue** → **Register**
9. 重复以上步骤注册所有目标设备（最多 100 台 iPhone + 100 台 iPad + 100 台 Apple Watch）

**一次可以批量添加**：如果设备多，可以点「Register Multiple Devices」→ 下载模板 CSV → 填入所有 UDID → 上传批量注册。

#### 第三步：创建 Ad Hoc Provisioning Profile

1. **Profiles** → **＋**
2. 选择 **Ad Hoc**（不要选 Development 或 App Store）→ Continue
3. **App ID**：选择 `com.ccswitch.ccSwitch`
4. **Certificates**：勾选你的开发证书
5. **Devices**：勾选你要分发的所有设备
6. **Name**：起个名字，例如「CC Switch Ad Hoc v1.0」
7. 点击 **Generate** → **Download**
8. 下载得到 `.mobileprovision` 文件

#### 第四步：用 Ad Hoc Profile 签名 IPA

**方法 A：在 Xcode 中直接签名（推荐）**

```bash
cd "/Users/martin/Desktop/CC Switch"

# 双击安装 provisioning profile
open ~/Downloads/CC_Switch_AdHoc.mobileprovision

# 打开 Xcode 项目
open ios/Runner.xcworkspace
```

在 Xcode 中：
1. 选 **Runner** target → **Signing & Capabilities**
2. 取消勾选 **Automatically manage signing**（手动管理）
3. **Provisioning Profile** 下拉 → 选择刚安装的 **CC Switch Ad Hoc v1.0**
4. **Signing Certificate** → 选择你的 iOS Distribution 证书
5. 顶部设备选择 **Any iOS Device (arm64)**
6. **Product → Archive**
7. 在 Organizer 中 → **Distribute App → Ad Hoc → Export**
8. 导出 `.ipa` 文件

**方法 B：用命令行签名**

```bash
# 找到签名证书的 SHA
security find-identity -v -p codesigning | grep "iPhone Distribution"

# 重新签名
cd extracted/Payload
cp ~/Downloads/CC_Switch_AdHoc.mobileprovision Runner.app/embedded.mobileprovision
codesign -f -s "iPhone Distribution: Your Name (XXXXXXXXXX)" \
  --entitlements entitlements.plist \
  Runner.app

# 重新打包 IPA
cd ..
zip -r ../CC_Switch_AdHoc.ipa Payload
```

#### 第五步：OTA 分发（和方案四一样）

和「方法四：企业证书」一样，需要 HTTPS 服务器 + manifest.plist + itms-services 安装链接。

manifest.plist 示例（与方案四相同，只需改 URL）：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>items</key>
    <array>
        <dict>
            <key>assets</key>
            <array>
                <dict>
                    <key>kind</key>
                    <string>software-package</string>
                    <key>url</key>
                    <string>https://your-server.com/CC_Switch_AdHoc.ipa</string>
                </dict>
            </array>
            <key>metadata</key>
            <dict>
                <key>bundle-identifier</key>
                <string>com.ccswitch.ccSwitch</string>
                <key>bundle-version</key>
                <string>1.0.0</string>
                <key>kind</key>
                <string>software</string>
                <key>title</key>
                <string>CC Switch</string>
            </dict>
        </dict>
    </array>
</dict>
</plist>
```

#### 第六步：通知用户安装

用户安装流程与方案四相同：Safari 点链接 → 安装 → 信任证书。

**Ad Hoc 特有的信任步骤**：
- **设置 → 通用 → VPN 与设备管理**
- 在「开发者 App」下找到你的开发者名称
- 点击 **信任**

---

## 六种方案对比总结

| | TestFlight | AltStore | Sideloadly | 企业证书 | Ad Hoc + OTA | Finder 侧载 |
|---|---|---|---|---|---|---|
| **费用** | $99/年 | 免费 | 免费 | $299/年 | $99/年 | $99/年 或免费 |
| **有效期** | 90 天 | 无限（自动续） | 7 天（手动续） | 1 年 | 1 年 | 1 年 / 7 天 |
| **需要 UDID** | ❌ | ❌ | ❌ | ❌ | ✅ 最多 100 台 | ❌ |
| **需要信任证书** | ❌ | ✅ | ✅ | ✅ | ✅ | ✅(免费) ❌(付费) |
| **安装方式** | TestFlight | AltStore | 拖拽 | Safari 链接 | Safari 链接 | Finder 拖拽 |
| **用户操作难度** | ⭐ 极简 | ⭐⭐ 中等 | ⭐ 简单 | ⭐ 简单 | ⭐ 简单 | ⭐ 极简 |
| **开发者操作难度** | ⭐⭐ | ⭐ | ⭐ | ⭐⭐⭐ | ⭐⭐⭐ | ⭐ 极简 |
| **需要服务器** | ❌ | ❌ | ❌ | ✅ HTTPS | ✅ HTTPS | ❌ |
| **自动更新** | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| **审核要求** | TestFlight 审核 | 无 | 无 | 无 | 无 | 无 |
| **吊销风险** | 低 | 低 | 低 | 中 | 低 | 低 |
| **最多设备数** | 10,000 | 3/Apple ID | 3/Apple ID | 无限 | 100 台 | 无限制 |
| **系统要求** | iOS 8+ | iOS 14+ | iOS 12+ | iOS 8+ | iOS 8+ | **iOS 26+** |
| **App Store 上架** | ✅ 可转正式 | ❌ | ❌ | ❌ | ❌ | ✅ 可转正式 |

---

## 方法六：iOS 26 Finder 侧载（原生安装，无需第三方工具）

### 是什么

macOS 26 + iOS 26 新增了通过 **Finder 直接安装 App** 的功能。签名好的 IPA 可以直接在 Finder 中拖到 iPhone 上安装，不需要任何第三方工具。

### 条件

- macOS 26+ / iOS 26+
- 开发者账号（$99/年 付费 或 免费 Apple ID 均可）
- USB 数据线连接 iPhone

### 步骤

1. **签名打包**
   ```bash
   cd "CC Switch"
   flutter build ios --release   # 自动签名
   ```

2. **在 Finder 中安装**
   - 用数据线连接 iPhone 到 Mac
   - 解锁 iPhone，点「信任此电脑」
   - 打开 Finder → 左侧边栏「位置」→ 点击你的 iPhone
   - 把 `dist/CC_Switch_iOS.ipa` 拖到 Finder 中 iPhone 页面上
   - App 自动传输并安装

3. **首次信任证书**（免费 Apple ID 需要）
   - iPhone：设置 → 通用 → VPN 与设备管理
   - 找到你的 Apple ID → 点信任

4. **命令行安装**（替代 Finder 拖拽）
   ```bash
   xcrun devicectl device install app \
     --device <DEVICE_IDENTIFIER> \
     dist/CC_Switch_iOS.ipa
   ```

### 优点

- macOS 原生功能，零第三方软件
- 安装速度快，操作直观
- 付费开发者签名有效期 1 年

### 缺点

- 仅 iOS 26+ / macOS 26+（新系统，覆盖面有限）
- 必须用 USB 数据线（不支持 WiFi 安装）
- 免费 Apple ID 仍只有 7 天

### 当前 CC Switch 状态

IPA 已用 `Apple Development: WTL6966N9B (Team: BU89V345NK)` 签名，2 台设备已注册，可直接安装。

---

## 推荐选择

| 你的场景 | 推荐方案 |
|----------|----------|
| 个人开发者，提前给朋友试用 | **AltStore** — 免费，WiFi 自动续签，不需要买开发者账号 |
| 小团队（5-20 人）内部测试 | **TestFlight** — $99/年，一键安装，自动更新，体验最好 |
| 大量用户 Beta 测试（100-10,000 人） | **TestFlight** — 公开链接分发，规模最大 |
| 公司内部 App（不限设备数） | **企业证书** — $299/年，Safari 直装，无限制 |
| 已知特定设备（≤100 台），不想审核 | **Ad Hoc + OTA** — $99/年，可控设备列表 |
| 只想给身边 1-3 个人用 | **Sideloadly** — 最快，拖进去就行 |
| 已有开发者账号，iOS 26+ 用户 | **Finder 侧载** — 原生功能，拖拽安装，零工具 |
