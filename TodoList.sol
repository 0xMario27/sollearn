// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

contract TodoList {
    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todos;

    function create(string calldata _text) external {
        todos.push(Todo({text: _text, completed: false}));
    }

    function updateText(uint256 _index, string calldata _text) external {
        // 两种方法更新
        // 1、直接操作指定位置的结构体。
        todos[_index].text = _text;
        // 2、放在存储类型中更新。
        Todo storage todo = todos[_index];
        todo.text = _text;
        // 对于两者的区别，也就是gas的一些特点。不同的情况下不相同。
        // 但比如只更新一个字段第一种比较节省。
        // 但如果更新多个字段。第二种相对于会更节省。
    }

    // 状态变量默认是有个get方法。
    function get(uint256 _index) external view returns (string memory, bool) {
        // 两种方式获取
        // 1、直接放在memory的类型中。
        Todo memory todo = todos[_index];
        // 2、放在storage的类型中。
        Todo storage todo2 = todos[_index];
        // 同样的gas的消耗略有不同。
        // storage比memory稍微节省一点。
        return (todo.text, todo.completed);
        // return (todo2.text, todo2.completed)
    }

    function toggleCompleted(uint256 _index) external {
        todos[_index].completed = !todos[_index].completed;
    }
}
// 疑问
// 1、memory的拷贝是拷贝的什么？
