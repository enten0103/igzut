import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:igzut/route/route.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("关于"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(Icons.medical_information_rounded, size: 64),
                  const SizedBox(height: 16),
                  const Text(
                    'igzut',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '版本 1.0.0',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 应用介绍卡片
          Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '简介',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  const SizedBox(height: 8),
                  Text('    igzut是一款开源的第三方教务系统客户端，旨在为学生提供更现代的教务管理体验。',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface)),
                ],
              ),
            ),
          ),
          Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '声明',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  const SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text:
                              '    此项目为本人初学flutter的练手项目,绝大部分代码在学习过程由AI辅助中写就,关于一些基础语法和第三方库的使用不甚熟练，软件UI和交互逻辑亦存在不和谐之处，',
                        ),
                        TextSpan(
                          text: '实际上我长期寻求一位专业的UI/UX设计',
                          style: TextStyle(
                            fontFamily: "NotoSerif",
                            color: Theme.of(context).colorScheme.onSurface,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 2,
                          ),
                        ),
                        const TextSpan(
                          text: '，如若您对这个项目有所想法，欢迎在github提出宝贵的意见或参与贡献代码',
                        ),
                      ],
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Card(
            elevation: 0,
            child: InkWell(
              onTap: () =>
                  launchUrl(Uri.parse("https://github.com/enten0103/igzut")),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.code, size: 32),
                    const SizedBox(width: 16),
                    const Text(
                      'GitHub',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                Get.offNamed(RouteConfig.loginPage);
              },
              child: Text("退出登录"))
        ],
      ),
    );
  }
}
