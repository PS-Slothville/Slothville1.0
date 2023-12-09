<script lang="ts">
    import { gameSettings, currentActiveGameDetails, closeGame } from "../stores/GameLauncherStore";
    import { createEventDispatcher, onMount } from "svelte";
    import fetchNui from "../../utils/fetch";
    import mojs from '@mojs/core';
    import { convertVwToPx, getRandomArbitrary, isDevMode } from "../stores/GeneralStores";

    const dispatch = createEventDispatcher();

    let gameStarted = false;
    let gameEnded = false;
    let lifes = $currentActiveGameDetails.gameLifes;
    let time = $currentActiveGameDetails.gameTime * 1000;
    let shuffleTime = $currentActiveGameDetails.gameShuffleTime * 1000;
    let GridSize = $currentActiveGameDetails.gameSize;
    let MaxNumber = GridSize * GridSize;
    let Boxes = [];
    let CurrentNumber = 1;
    let CurrentFails = 0
    var ShuffleBarInterval = null;

    onMount(() => {
        ShuffleNumbers();
        var TimerBar = document.getElementById("NumberUp-TimerBar");
        var TimerBarWidth = 0;
        var TimerBarInterval = setInterval(TimerBarframe, time/1000);
        function TimerBarframe() {
            if (TimerBarWidth >= 100) {
                clearInterval(TimerBarInterval);
                EndGame(false);
                return;
            } else {
                TimerBarWidth+= 0.1;
                TimerBar.style.width = TimerBarWidth + "%";
            }
        };
        var ShuffleBar = document.getElementById("NumberUp-ShuffleBar");
        var ShuffleBarWidth = 0;
        ShuffleBarInterval = setInterval(ShuffleBarframe, shuffleTime/1000);
        function ShuffleBarframe() {
            if (ShuffleBarWidth >= 100) {
                ShuffleBarWidth = 0;
                ShuffleNumbers();
                return;
            } else {
                ShuffleBarWidth+= 0.1;
                ShuffleBar.style.width = ShuffleBarWidth + "%";
            }
        };
        gameStarted = true;
    });

    function ShuffleNumbers() {
        let i = 0;
        Boxes.length = 0;
        while(i < MaxNumber) {
            var key = Math.floor(Math.random() * MaxNumber) + 1;
            const boxIndexInArray = Boxes.findIndex((item) => item.cubeIndex === key);
            if (boxIndexInArray == -1) {
                const boxData = {
                    cubeIndex: key,
                    isClicked: CurrentNumber > key? true : false
                };
                Boxes.push(boxData);
                Boxes = Boxes;
                i++;
            }
        };
    };

    function BoxClicked(box) {
       if (CurrentNumber == box.cubeIndex) {
        CurrentNumber++;
        const boxIndexInArray = Boxes.findIndex((item) => item.cubeIndex === box.cubeIndex);
        let updatedBox = box;
        updatedBox.isClicked = true;
        Boxes[boxIndexInArray] = updatedBox;
        if (CurrentNumber == MaxNumber) {
            EndGame(true);
            return;
        };
       } else {
        CurrentFails++;
        if (CurrentFails >= lifes) {
            EndGame(false);
            return;
        };
       }
    };

    function EndGame(bool) {
        if (!gameEnded) {
            gameEnded = true;
            clearInterval(ShuffleBarInterval);
            setTimeout(() => {
                if(!isDevMode) {
                    fetchNui($gameSettings.triggerEvent, { success: bool });
                }
                dispatch('game-ended', {hackSuccess: bool})
            }, 500);
        }
    }
</script>

<div class="NumberUp-base">
    {#if lifes > 1 }
        <div id="NumberUp-LifesBar"class="NumberUp-LifesBar">
            {#each Array(lifes) as _, i}
                <div
                    id="NumberUp-Life{i+1}"
                    class="NumberUp-Life {CurrentFails >= i+1? 'ps-bg-wrong-cube' : ''}"
                    >
                </div> 
            {/each}
        </div>
    {/if}
    <div class="NumberUp-TimerBarBase">
        <div class="NumberUp-TimerBar" id="NumberUp-TimerBar"></div>
    </div>
    <div id="NumberUp-KeyArea" class="NumberUp-KeyArea" style="grid-template-columns: repeat({GridSize}, 1fr); grid-template-rows: repeat({GridSize}, 1fr); gap: 0.5vh;">
        {#each Boxes as box}
            <div 
                id={'NumberUp-Number-'+box.cubeIndex} 
                on:click={() => BoxClicked(box)}
                class="NumberUp-Number {box.isClicked? 'cursor-default' : 'cursor-pointer'} {box.isClicked? 'ps-bg-green-cube' : ''}">
                <svg viewBox="-11.5 -22 38 30" class="Numberup-Text">
                    <text x="{box.cubeIndex < 10? 3.5: 0}" y="0" color="white">{box.cubeIndex}</text>
                </svg>
            </div>
        {/each}
    </div>
    <div class="NumberUp-TimerBarBase">
        <div class="NumberUp-TimerBar" id="NumberUp-ShuffleBar" style="background-color: #257cad;"></div>
    </div>
</div>

<style>
    .NumberUp-base {
        display: flex;
        flex-direction: column;
        height: 28vw;
        justify-content: center;
        align-items: center;
        -moz-user-select: none;
        -khtml-user-select: none;
        -webkit-user-select: none;
        -ms-user-select: none;
        user-select: none;
    }
    .NumberUp-LifesBar {
        margin-top: -1vh;
        width: 27vw;
        height: 2vh;
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(0.1vh, 1fr));
        gap: 1vh;
    }
    .NumberUp-Life {
        border-radius: 0.4vh;
        background-color: var(--cube-bg-darkgreen);
    }
    .NumberUp-TimerBarBase  {
        margin-top: 0.5vw;
        width: 27vw;
        height: 1vh;
        border-radius: 0.4vh;
        overflow: hidden;
        background-color: var(--cube-bg-darkgreen);
    }
    .NumberUp-TimerBar {
        height: 100%;
        width: 0%;
        background-color: var(--color-green); 
    }
    .NumberUp-KeyArea {
        margin-top: 0.5vw;
        width: 27vw;
        height: 29vw;
        display: grid;
    }
    .NumberUp-Number {
        border: 2px solid var(--color-green);
        background-color: var(--cube-bg-darkgreen);
    }
    .NumberUp-Number:hover {
        filter: brightness(80%);
    }
    .Numberup-Text {
        width: 100%;
        fill: white;
    }
    .ps-bg-green-cube {
        pointer-events: none;
		background-color: var(--color-green) !important;
	}
    .ps-bg-wrong-cube {
		background-color: var(--color-red) !important;
	}
</style>