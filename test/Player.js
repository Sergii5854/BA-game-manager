const Player  = artifacts.require("Player");

contract('Player', accounts => {

    let instance
    let owner = accounts[0]
    let account = accounts[1]
    const nickName = "Sergii "

    beforeEach('instance', async () => {
        instance = await Player.new(nickName,account, owner)
    })

    it('should be valid instance Player', async () =>{
        assert.equal(typeof instance, 'object')
    })

    it('create player with nickName', async () => {
        assert.equal(await instance.nickName(), nickName)
    })

})