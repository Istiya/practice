class Player{
  int attack;
  int currentHealth;
  int maxHealth;
  int exp;
  int numberDefeatedEnemies;
  int numberDeaths;
  double rating;
  late String nickname;

  Player(this.attack, this.currentHealth, this.maxHealth, this.exp, this.numberDefeatedEnemies, this.numberDeaths, this.rating, this.nickname);

  static Player getNewPlayer(String nickname){
    return Player(10, 10, 10, 0, 0, 0, 0, nickname);
  }
}
