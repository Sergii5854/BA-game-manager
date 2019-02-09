const GM  = artifacts.require("GameManager");


contract('GM', accounts => {
    let instance;
    let owner = accounts(0);
    let account = accounts(0);

    // it('GameManager joinGame ', async () =>{
    //     const game = await instance.joinGame({from: owner})
    //     let player = await game.player1();
    //     assert.equal( game, player)
    // })

})