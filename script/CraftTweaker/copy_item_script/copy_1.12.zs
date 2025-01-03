import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.player.IPlayer;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
import crafttweaker.item.ITooltipFunction;
import crafttweaker.formatting.IFormattedText;
import crafttweaker.world.IWorld;
import crafttweaker.item.IMutableItemStack;


var Magnification_item as int []  = [1]; 
var a as int [] = [0];
var Magnification as string [] = ["设置物品数量为2","×2","×8","×64","×100"];

var book = <minecraft:enchanted_book>.withTag({
    display: {
        Name: "§bCopy",
        Lore: ["§7One life is two", "§7two is three", "§7three is everything"]
    },
});
book.addAdvancedTooltip(function(item) {
    if(a[0] < 5 && a[0] > 0){
        return "§a当前复制倍率为:§b " ~ Magnification[a[0]];
    }else if(a[0] == 0){
        return "§a复制不可堆叠物品(设置物品数量为2)";
    }
    return "";   
});


recipes.addShaped("copy_book", book, [
        [<minecraft:stick>, null, null],   
        [null, null, null],
        [null, null, <minecraft:stick>]
    ]);


events.onPlayerRightClickItem(function(event as PlayerRightClickItemEvent){
                
                var player as IPlayer = event.player;               
                var world as IWorld = player.world;
                var player_item = player.currentItem; 
                var item_copy = player.getHeldItemOffHand();                

                                                
                if(!isNull(item_copy) && !isNull(player_item) && player_item.displayName == book.displayName && player_item.name == book.name){
                  if(world.remote)return;
                  if(a[0] < 5 && a[0] > 0){
                    player.give(item_copy * Magnification_item[0]);
                  }else if(a[0] == 0){
                    var item_copy0 = item_copy.mutable();
                    item_copy0.withAmount(2);
                  }
                }else if(!world.remote && isNull(item_copy) && !isNull(player_item) && player_item.displayName == book.displayName && player_item.name == book.name){                       
                        var i = a[0] + 1;
                        if(i == 1){
                            a[0] = i;
                            Magnification_item[0] = 1;
                            player.sendStatusMessage(format.red("当前复制倍率为:×2"));
                        }else if(i == 2){
                            a[0] = i;
                            Magnification_item[0] = 4;
                            player.sendStatusMessage(format.red("当前复制倍率为:×8"));
                        }else if(i == 3){
                            a[0] = i;      
                            Magnification_item[0] = 32;
                            player.sendStatusMessage(format.red("当前复制倍率为:×64"));
                        }else if(i == 4){
                            a[0] = i;      
                            Magnification_item[0] = 50;
                            player.sendStatusMessage(format.red("当前复制倍率为:×100"));
                        }else{
                            a[0]= 0;                                                              
                            player.sendStatusMessage(format.red("复制不可堆叠物品(设置物品数量为2)"));
                        }
                    }
});   




