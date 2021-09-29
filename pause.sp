#pragma semicolon 1
#include <cstrike>
#include <sourcemod>
#include <sdktools>
public Plugin:myinfo = {
    name = "Admin Pause",
    author = "YuXiaoyu",
    description = "CS:GO Pause Commands For Admin",
    version = "1.0",
    url = "https://yu.hi.cn"
};

public OnPluginStart() {
    RegConsoleCmd("sm_pause", Command_ForcePause, "pause");
    RegConsoleCmd("sm_unpause", Command_ForceUnpause, "unpause");
}

stock void Colorize(char[] msg, int size, bool stripColor = false) {
  for (int i = 0; i < sizeof(_colorNames); i++) {
    if (stripColor)
      ReplaceString(msg, size, _colorNames[i], "\x01");
    else
      ReplaceString(msg, size, _colorNames[i], _colorCodes[i]);
  }
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
