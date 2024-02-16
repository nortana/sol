// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Vote {
    event Log(string);
    event Log(bool);
    event Log(address);

    // 投票人的结构体
    struct Voter {
        uint256 amount; //票数
        bool isVoted; //是否投票了
        address delegator; //代理人地址
        uint256 targetId; // 目标ID
    }

    //投票看板结构体
    struct Board {
        string name; //目标名字
        uint256 totalAmount; //票数
    }

    //主持人信息
    address public host;

    //创建投票人集合
    mapping(address => Voter) public voters;

    // 主体集合
    Board[] public board;

    //数据初始化
    constructor(string[] memory nameList) {
        host = msg.sender;

        //给主持人初始化一票
        voters[host].amount = 1;

        //初始化Board

        for (uint256 i = 0; i < nameList.length; i++) {
            Board memory boardItem = Board(nameList[i], 0);
            board.push(boardItem);
        }
    }

    // 返回看板集合

    function getBoardInfo() public view returns (Board[] memory) {
        return board;
    }

    //给某些地址赋予选票
    function mandate(address[] calldata addressList) public {
        //只有主持人可以调用该方法
        require(host == msg.sender, "Only the owner has permissions.");

        for (uint256 i = 0; i < addressList.length; i++) {
            //如股票该地址已经投过票，不做处理
            if (!voters[addressList[i]].isVoted) {
                voters[addressList[i]].amount = 1;
            }
        }
    }

    //将投票权委托给别人
    function delegate(address to) public {
        // 获取委托人信息
        Voter storage sender = voters[msg.sender];

        //如果委托人投过票了，不能在委托
        require(!sender.isVoted, unicode"您已经投过票了。");
        //不能委托给自己
        require(msg.sender != to, unicode"不能委托给自己");

        //避免循环委托
        while (voters[to].delegator != address(0)) {
            to = voters[to].delegator;
            require(to == msg.sender, unicode"不能循环代理授权.");
        }

        //开始授权
        sender.isVoted = true;
        sender.delegator = to;
        voters[msg.sender] = sender;

        //代理人数据的修改
        Voter storage delegator_ = voters[to];
        if (delegator_.isVoted) {
            //追票
            board[delegator_.targetId].totalAmount += sender.amount;
        } else {
            delegator_.amount += sender.amount;
        }
        voters[to] = delegator_;
    }

    //投票

    function vote(uint256 targetId) public {
        Voter memory sender = voters[msg.sender];
        require(sender.amount != 0, "has no right to vote.");
        require(!sender.isVoted, "Already voted.");

        sender.isVoted = true;
        //  emit Log(unicode"当前账号");
        //  emit Log(msg.sender);
        // emit Log(sender.isVoted);
        sender.targetId = targetId;

        voters[msg.sender] = sender;
        board[targetId].totalAmount += sender.amount;

        emit voteSuccess(unicode"投票成功");
    }

    //投票成功事件
    event voteSuccess(string);
}

/**

{
    ["0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2","0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db","0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB","0x617F2E2fD72FD9D5503197092aC168c91465E7f2"]
    李四：0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
    李五：0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
    李六：0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB
    李七：0x617F2E2fD72FD9D5503197092aC168c91465E7f2

    0x5B38Da6a701c568545dCfcB03FcB875f56beddC4:{
        amount:1
        isVoted:false
        delegator:0xdsfe
        targetId:1
    }
}

[
    {
        name:'李四'，
        totalAmount;10
    },
    {
        name:'李五'，
        totalAmount;20
    }
]


['李四','李五','李六','李七']

*/
