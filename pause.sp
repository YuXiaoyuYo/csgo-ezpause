#pragma semicolon 1
#include <cstrike>
#include <sourcemod>
#include <sdktools>
public Plugin:myinfo = {
    name = "Admin Pause",
    author = "YuXiaoyu",
    description = "CS:GO Pause Commands",
    version = "1.1",
    url = "https://yu.nm.cn"
};

public OnPluginStart() {
    RegConsoleCmd("sm_pause", Command_ForcePause, "pause");
    RegConsoleCmd("sm_p", Command_ForcePause, "pause");
    RegConsoleCmd("sm_unpause", Command_ForceUnpause, "unpause");
    RegConsoleCmd("sm_unp", Command_ForceUnpause, "unpause");
}

public Action:Command_ForcePause(client, args) {
    if (IsPaused()){
        PrintToChat(client, "已经有\x02暂停\x01正在进行");
        return Plugin_Handled;
        }

    ServerCommand("mp_pause_match");
    PrintToChatAll(" \x04%N \x01发起了暂停", client);
    return Plugin_Handled;
}

public Action:Command_ForceUnpause(client, args) {
    if (!IsPaused()) {
        PrintToChat(client, "没有\x02任何暂停\x01正在进行");
        return Plugin_Handled;
        }

    ServerCommand("mp_unpause_match");
    PrintToChatAll(" \x04%N \x01取消了暂停", client);
    return Plugin_Handled;
}

stock bool:IsValidClient(client) {
    if (client > 0 && client <= MaxClients && IsClientConnected(client) && IsClientInGame(client))
        return true;
    return false;
}

stock bool:IsPaused() {
    return bool:GameRules_GetProp("m_bMatchWaitingForResume");
}
