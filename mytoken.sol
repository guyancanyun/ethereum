contract ERC20 {

    string public constant name = "Token Name";//token的名字、代币名称
    string public constant symbol = "SYM"; // token的简写/代币符号
    uint8 public constant decimals = 18;  // 代币小数点位数，代币的最小单位， 18表示我们可以拥有 .0000000000000000001单位个代币。 官方推荐18。不要轻易改变

      function totalSupply() constant returns (uint totalSupply);//发行代币总量。 
      function balanceOf(address _owner) constant returns (uint balance);//查看对应账号的代币余额。 
      function transfer(address _to, uint _value) returns (bool success);//实现代币交易，用于给用户发送代币（从我们的账户里）。 
      function transferFrom(address _from, address _to, uint _value) returns (bool success);//实现代币用户之间的交易。 
      function approve(address _spender, uint _value) returns (bool success);//允许用户可花费的代币数。
      function allowance(address _owner, address _spender) constant returns (uint remaining);//控制代币的交易，如可交易账号及资产。 

      event Transfer(address indexed _from, address indexed _to, uint _value);
      event Approval(address indexed _owner, address indexed _spender, uint _value);
}

