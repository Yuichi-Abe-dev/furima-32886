function calculate (){
  const itemPrice = document.getElementById("item-price");
  //販売手数料率
  const feeRates = 0.1;
  itemPrice.addEventListener("keyup", () => {
    //手数料利益の計算
    const calcFee = itemPrice.value * feeRates;
    const calcGain = itemPrice.value * (1 - feeRates);
    //手数料と利益の要素の取得
    const itemFee = document.getElementById("add-tax-price");
    const itemGain = document.getElementById("profit");
    //手数料と利益の表示
    itemFee.innerHTML = `${calcFee}`;
    itemGain.innerHTML = `${calcGain}`;
  });
}

window.addEventListener('load', calculate);