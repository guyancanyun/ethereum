# Solidity语法学习

## 基本数据类型
>  布尔类型
```
true
false
```
> 整型
```
# 常见uint 代表uint256
int8 & int256
uint8 & uint256

# 类型推断
var i = 123 #uint
var s = "string" #自动转string

#类型转换，大转小可能截断
uint32 a = 0x12345678;
uint16 b = uint16(a); // b will be 0x5678 now
```
> 枚举
```
enum Direction {East, South, West, North}
Direction constant myDirection = Direction.South;

 function getDirection()public pure returns (Direction) {
    return myDirection;
 }
```
>常量

一旦定义不能修改
## 引用类型
> 字符串
```
string str = "Hello";
```
> 字节
```
bytes32 bts = "World";
function lenght() public view returns(uint){
  // length 返回长度
  return bts.length;
}
```
> 数组array
```
uint[] public intArray;
  function add(uint val) public {
    intArray.push(val);
  }

  function getInt(uint _index) public view returns (uint) {
    assert(intArray.length > _index);
    return intArray[_index];
  }
// 动态数组
function memArr() public view returns (uint) {
  uint[] memory a = new uint[](7);
  uint[3] memory b = [uint(1), 2, 3];
}
```
> 结构体struct
```
struct User {
      string name;
      uint age;
  }
```
> 字典mapping
```
mapping (bytes32 => uint) balances;
  
  function add(bytes32 key, uint amt) public {
      balances[key] += amt;
  }
  
  function get(bytes32 key) public returns (uint) {
      return balances[key];
  }
```

## 地址address
```
属性
<address>.balance, 地址的余额（单位为：wei）
<address>.transfer,发送以太币（单位为：wei）到一个地址，如果失败会停止并抛出异常。
函数：

send() // 相对于transfer，send的级别较低。如果执行失败，当前合约不会因为异常而停止，但是send方法会返回false。
注意事项：
调用递归深度不能超1024。
如果gas不够，执行会失败。
所以使用这个方法要检查成功与否。或为保险起见，货币操作时要使用一些最佳实践。
如果执行失败，将会回撤所有交易，所以务必留意返回结果。

call()
delegatecall()
callcode()
// call()，delegatecall()，callcode()都是底层的消息传递调用，最好不使用，会破坏安全性。
```
## 交易
```
block.blockhash(uint blockNumber) returns (bytes32)，给定区块号的哈希值，只支持最近256个区块，且不包含当前区块。
block.coinbase (address) 当前块矿工的地址。
block.difficulty (uint)当前块的难度。
block.gaslimit (uint)当前块的gaslimit。
block.number (uint)当前区块的块号。
block.timestamp (uint)当前块的时间戳。
now (uint)当前块的时间戳，等同于block.timestamp

msg.data (bytes)完整的调用数据（calldata）。
msg.gas (uint)当前还剩的gas。
msg.sender (address)当前调用发起人的地址。
msg.sig (bytes4)调用数据的前四个字节（函数标识符）。
msg.value (uint)这个消息所附带的货币量，单位为wei。

tx.gasprice (uint) 交易的gas价格。
tx.origin (address)交易的发送者（完整的调用链）

地址常见的属性：
<address>.balance (uint256)：Address的余额，以wei为单位。
<address>.transfer(uint256 amount)：发送给定数量的ether，以wei为单位，到某个地址。失败时抛出异常。
<address>.send(uint256 amount) returns (bool):发送给定数量的ether，以wei为单位，到某个地址。失败时返回false。

错误判断：
assert(bool condition):如果条件不满足，则抛出 - 用于内部错误。
require(bool condition):如果条件不满足，则抛出 - 用于输入或外部组件中的错误。
revert():中止执行并恢复状态更改

selfdestruct(owner)

```


## 函数
> 作用域  
- public
- private
- internal
- external

## event事件


## 其他
> Indexed属性

事件参数上增加indexed属性，最多可以对三个参数增加这样的属性
增加了indexed的参数值会存到日志结构的Topic部分，便于快速查找。而未加indexed的参数值会存在data部分，成为原始日志。

> view  

函数可以被声明为view，在这种情况下，它们承诺不修改状态。

以下语句被认为是修改状态：

写入状态变量。
发射事件。
创建其他合约。
使用selfdestruct。
通过调用发送Ether。
调用其他函数不被标记view或者pure。
使用低等级调用。
使用包含某些操作码的内联汇编。

除了上述状态修改语句的列表外，以下是从状态读取的：

从状态变量读取。
访问this.balance或.balance。
访问block，tx，msg的任何成员（除了msg.sig和msg.data）。
调用任何未标记为pure的功能。
使用包含某些操作码的内联汇编。

> pure

函数可以声明为pure，在这种情况下，它们承诺不会从该状态中读取或修改该状态。

> 库library

限制
无状态变量(state variables)。
不能继承或被继承
不能接收ether。

> using for

指令using A for B;用来附着库里定义的函数(从库A)到任意类型B。这些函数将会默认接收调用函数对象的实例作为第一个参数。

> fallback

每一个合约有且仅有一个没有名字的函数。这个函数无参数，也无返回值。
1.调用合约时，没有匹配上任何一个函数(或者没有传哪怕一点数据)，就会调用默认的回退函数。
2.当合约收到ether时（没有任何其它数据），也会调用默认的回退函数。
避免用过多gas：
写入到存储(storage)，创建一个合约，执行一个外部(external)函数调用，发送ether
一个没有定义一个回退函数的合约。如果接收ether，会触发异常，并返还ether

> 数据位置memory和storage

memory 存在于内存，可回收，calldata类似
storage 永远存在
同位置的赋值传引用，不同位置转换会拷贝

强制的数据位置(Forced data location)

外部函数(External function)的参数(不包括返回参数)强制为：calldata
状态变量(State variables)强制为: storage

默认数据位置（Default data location）

函数参数（括返回参数：memory
所有其它的局部变量：storage
