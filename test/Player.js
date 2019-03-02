const Player  = artifacts.require("Player");
const TiCtAcToE  = artifacts.require("TiCtAcToE");

contract('Player', accounts => {

    let instance
    let owner = accounts[0]
    let account = accounts[1]
    const nickName = "Sergii "


    beforeEach('instance', async () => {

        instance = await Player.new(nickName, account, owner)
    })

    it('should be valid instance Player', async () =>{
        assert.equal(typeof instance, 'object')
    })

    it('create player with nickName', async () => {
        assert.equal(await instance.nickName(), nickName)
    })

    it('Player start game  with Zero wins ', async () => {
        assert.equal(await instance.wins(), 0)
    })
    it('Player start game  with Zero loses ', async () => {
        assert.equal(await instance.loses(), 0)
    })
    it('Player start game  with Zero account ', async () => {
        assert.equal(await instance.gm(), account);
    })

    it('Player check recentCreatedGame   ', async () => {
        const newGame =  await  TiCtAcToE.new()
        await instance.setLatestGame( newGame.address, {from: account})

        assert.equal( await instance.recentCreatedGame() ,  newGame.address);
    })

    it('Player check incLosses function  ', async () => {
        const newGame =  await  TiCtAcToE.new()
        await instance.setLatestGame( owner, {from: account})
        const beforeLosesss = await instance.loses();
        await instance.incLosses({from: owner })

        assert.equal(beforeLosesss+1 , (await instance.loses()).toNumber() );
    })
    it('Player check incWins function  ', async () => {
        const newGame =  await  TiCtAcToE.new()
        await instance.setLatestGame( owner, {from: account})
        const beforeWins = await instance.wins();
        await instance.incWins({from: owner })

        assert.equal(beforeWins+1 , (await instance.wins()).toNumber() );
    })

})
