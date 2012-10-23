## 快递跟踪 [![测试結果](https://secure.travis-ci.org/saberma/shopqi-app-express.png)](http://travis-ci.org/saberma/shopqi-app-express)


商品发货后需要持续跟踪物流情况，如果 3 天后仍未到货，要发邮件提醒管理员。


### 需求

* 安装时将所有已发货的订单同步过来

* 订单一发货时即时向应用发送订单记录

* 首页显示订单物流信息

* 每日发送 3 天以上未到货的订单，提醒管理员进行跟踪处理


### 使用

    $ bundle exec unicorn_rails -p 3000
    $ bundle exec rake jobs:work
