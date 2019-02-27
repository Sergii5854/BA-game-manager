const GM  = artifacts.require("GameManager");
const TiCtAcToE = artifacts.require("TiCtAcToE");

contract('GM', accounts => {
    let instance;
    let owner = accounts[0];
    let account = accounts[0];

    beforeEach('instance', async () => {
        instance = await GM.new()
    })

    it('should be valid instance GM', async () =>{
        assert.equal(typeof instance, 'object')
    })

    it('let user to join to TiCtAcToE game', async () => {
        await instance.joinGame("Sergii ", {from: owner})
        const games = await instance.askForGame()
        const gameInstance = await TiCtAcToE.at(games[0])
        const player = await gameInstance.player1()

        assert.equal(player, owner)

    })
})