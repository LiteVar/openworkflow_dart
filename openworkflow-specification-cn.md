# OpenWorkflow规范

版本 1.0.0

## 介绍

OpenWorkflow规范（OWS）定义了基于OpenTool规范（OTS）的通用工具按时序调用的标准，允许人类和计算机理解和设置服务的调用顺序，而无需访问源代码和文档。如果定义正确，消费者只需使用最少的实现逻辑即可按顺序使用该工具的接口。

### 参考

OpenWorkflow用于定义了工具接口调用时序，调用的工具基于OpenTool描述，并且已经实现了ToolDriver对具体工具接口的调用。

OpenTool目前已经实现的ToolDriver包括：[OpenAPI3/HTTP](https://github.com/djbird2046/openapi_dart), [OpenRPC/JsonRPC](https://github.com/djbird2046/openrpc_dart), [OpenModbus/RTU/ASCII/TCP/UDP](https://github.com/djbird2046/openmodbus_dart)

### 目标

期望用户无需了解程序代码，只需要编写（或是大语言模型生成）JSON文件，就可以根据JSON描述的顺序，逐个执行工具接口。

OpenWorkflow面向一般性的程序调用顺序描述，编写过程参考OpenTool描述，调用过程经由ToolDiver驱动具体工具的执行。

通过OpenWorkflow确定了调用顺序，可以使得一次编写（无论是人类还是大语言模型生成），往后一直可用。

## 对象

### OpenWorkflow对象

| 字段           | 类型                              | 描述                                                              |
|--------------|---------------------------------|-----------------------------------------------------------------|
| openworkflow | `string`                        | **必填**。当前OpenWorkflow的JSON文档版本。                                 |
| info         | Info对象                          | **必填**。描述当前OpenWorkflow文档的信息。                                   |
| workflow     | Map\[`string`, FunctionItem对象\] | **必填**。描述接口调用的顺序，各接口传入参数，返回参数的默认值。 第一个被调用的接口，Map的key名称为"start"。 |

### Info对象

| 字段          | 类型       | 描述                               |
|-------------|----------|----------------------------------|
| title       | `string` | **必填**。当前OpenWorkflow的JSON文档的标题。 |
| description | `string` | 当前OpenWorkflow文档的更详细的描述信息。       |
| version     | `string` | **必填**。当前文档的版本号，用于文档版本管理。        |

### FunctionItem对象

| 字段          | 类型                       | 描述                                                                  |
|-------------|--------------------------|---------------------------------------------------------------------|
| function    | `string`                 | **必填**。对应OpenTool的function的name。                                    |
| description | `string`                 | 当前调用此函数的描述。                                                         |
| arguments   | Map\[`string`, dynamic\] | **必填**。根据OpenTool中function的Parameter的描述格式，填入传入的具体数值。若无指定值，填入值为`{}`。 |
| results     | Map\[`string`, dynamic\] | **必填**。根据OpenTool中function的Return的描述格式。填入返回值的默认值。若无指定值，填入值为`{}`。    |
| next        | `string`                 | **必填**。下一步需要执行的步骤的名称。如果下一步无需有新的步骤，可以填入无对应名称的字符串。                    |
