let count = 0
const url = "https://kanestephens.com"
function updateCount(){
    document.getElementById("count").innerHTML = count;
}

async function increaseCount(){
    try{
    const response = await fetch(url)
    if(response.ok){
    count++;
    updateCount();
    }
}catch (error){
    console.error("Network error:", error)
}
}

increaseCount();