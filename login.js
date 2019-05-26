let objPeople = []

function User()
{
    username= "";
    password= "";
    role= "";
}


function getInfo() 
{
    var username = document.getElementById("username").value;
    var password = document.getElementById("password").value;
    console.log("username");
    for(i = 0; i = objPeople.length; i += 1) 
    {
        if (username == objPeople[i].username && password == objPeople[i].password) 
        {
            console.log ("Welcome to the Cloud")

            return
        }
    }
    console.log("You are not a real person")

}

function setInfo()
{
    let username = document.getElementById("username").value;
    let password = document.getElementById("password").value;
    let role = document.getElementById("role").value;
    console.log(username);
    console.log(password);
    console.log(role);
    console.log(objPeople.length);
    console.log(objPeople[0]);
    objPeople.push(new User(username, password, role));
    console.log(objPeople.length);
    console.log(objPeople[0]);

    if (objPeople.length=0){
        //new User(username,password,role)
        objPeople.push(new User(username, password, role));
        console.log("User Created");
        console.log(objPeople[0]);
    }
    else{
        for (i = 0; i < (objPeople.length); i++)
        {
            if (username != objPeople[i].username)
            {
                //let objPeople = new objPeople(username, password, role)
                new User(username,password,role)
                objPeople.push(username, password, role);
            }
            console.log(objPeople[i])
            console.log ("User already exists")
        }
    }
    
}

let login = document.querySelector('#login');
let create = document.querySelector('#create');

if (login){
    login.addEventListener('click', getInfo);
}

if (create){
    create.addEventListener('click', setInfo);
}