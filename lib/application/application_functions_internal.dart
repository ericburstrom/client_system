part of '../main.dart';

extension GameFunctionsInternal on Application {
  ClearFocus() {
    FocusStatus = [];
    for (var i = 0; i < NrPlayers; i++) {
      FocusStatus.add(List.filled(TotalFields, 0));
    }
  }

  CellClick(int player, int cell) {
    if (player == PlayerToMove &&
        MyPlayerId == PlayerToMove &&
        !FixedCell[player][cell] &&
        CellValue[player][cell] != -1) {
      net.SendSelection(player, cell, GameDices.DiceValue, GameId, PlayerIds);
      CalcNewSums(player, cell);
    }
  }

  CalcNewSums(int player, int cell) {
    if (GameDices.UnityDices[0]) {
      GameDices.SendResetToUnity();
    }

    AppColors[PlayerToMove + 1][cell] = Colors.green.withOpacity(0.7);
    FixedCell[PlayerToMove][cell] = true;
    // Update Sums
    var sum = 0;
    var totalSum = 0;
    var ts = 0;
    for (var i = 0; i < 6; i++) {
      if (FixedCell[PlayerToMove][i]) {
        ts++;
        sum += CellValue[PlayerToMove][i] as int;
      }
    }
    totalSum = sum;
    AppText[PlayerToMove + 1][6] = sum.toString();
    if (sum >= BonusSum) {
      AppText[PlayerToMove + 1][7] = BonusAmount.toString();
      totalSum += BonusAmount;
    } else {
      if (ts != 6) {
        AppText[PlayerToMove + 1][7] = (sum - BonusSum).toString();
      } else {
        AppText[PlayerToMove + 1][7] = "0";
      }
    }
    for (var i = 8; i <= TotalFields - 2; i++) {
      if (FixedCell[PlayerToMove][i]) {
        totalSum += CellValue[PlayerToMove][i] as int;
      }
    }
    AppText[PlayerToMove + 1][TotalFields - 1] = totalSum.toString();
    CellValue[PlayerToMove][TotalFields - 1] = totalSum;

    // New Rolls
    for (var i = 0; i < TotalFields; i++) {
      if (!FixedCell[PlayerToMove][i]) {
        AppText[PlayerToMove + 1][i] = "";
        CellValue[PlayerToMove][i] = -1;
      }
    }

    ClearFocus();
    PlayerToMove = (PlayerToMove + 1) % NrPlayers;
    if (!FixedCell[PlayerToMove].contains(false)) {
      // Game finished
      for (var i = 0; i < NrPlayers; i++) {
        highscore.Update(userName, CellValue[i][TotalFields - 1]);
      }
    }

    for (var i = 0; i < TotalFields; i++) {
      if (FixedCell[PlayerToMove][i]) {
        AppColors[0][i] = Colors.white.withOpacity(0.7);
      } else {
        AppColors[0][i] = Colors.white.withOpacity(0.3);
      }
    }
    for (var i = 0; i < NrPlayers; i++) {
      for (var j = 0; j < TotalFields; j++) {
        if (!FixedCell[i][j]) {
          if (i == PlayerToMove) {
            AppColors[i + 1][j] = Colors.greenAccent.withOpacity(0.3);
          } else {
            AppColors[i + 1][j] = Colors.grey.withOpacity(0.3);
          }
        }
      }
    }
    GameDices.ClearDices();
    AnimateBoard();
  }
}
