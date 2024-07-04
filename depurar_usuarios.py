"""
PyScript para la depuración instantánea de residuos de usuarios en Windows
Autor: @josuerom Fecha: 03/Julio/2024
"""
import os
import time
import shutil
import subprocess
import ctypes
from colorama import init, Fore, Style

init()

def obtener_usuarios():
   directorio_de_usuarios = r"C:\Users"
   carpetas_excluidas = ["soporte", "public", "all users", "default", "default user"]
   usuarios = [carpeta for carpeta in os.listdir(directorio_de_usuarios) if os.path.isdir(os.path.join(directorio_de_usuarios, carpeta)) and carpeta.lower() not in [ex.lower() for ex in carpetas_excluidas]]
   return usuarios


def eliminar_usuarios(lista_usuarios):
   for usuario in lista_usuarios:
      try:
         # Eliminar usuario
         subprocess.run(['powershell.exe', f'net user {usuario} /delete'], check=True)
         print(Fore.GREEN + Style.BRIGHT + f"Usuario eliminado: [{usuario}]" + Style.RESET_ALL)
         # Eliminar carpeta del usuario
         shutil.rmtree(os.path.join(r"C:\Users", usuario), ignore_errors=True)
         # Eliminar registros del usuario
         subprocess.run(['powershell.exe', f'Remove-Item -Path "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\ProfileList\\*" -Recurse -Force -ErrorAction SilentlyContinue -Filter "*{usuario}"'], check=True)
      except Exception as e:
         print(Fore.RED + Style.BRIGHT + f"Error al intentar eliminar el usuario: [{usuario}]: {e}" + Style.RESET_ALL)
   print(Fore.GREEN + Style.BRIGHT + f"Registros de usuarios residuales eliminados." + Style.RESET_ALL)


def firma_autor():
   print("******************************************")
   print(Fore.YELLOW + Style.BRIGHT + "MIJITO SE HAN DEPURADO LOS USUARIOS!\nAutor: @josuerom" + Style.RESET_ALL)
   print("******************************************\n")


def reiniciar_sistema():
   print(Fore.CYAN + Style.BRIGHT + "El sistema se reiniciará en 10 segundos..." + Style.RESET_ALL)
   time.sleep(10)
   os.system("shutdown /r /f")


def es_administrador():
   try:
      return ctypes.windll.shell32.IsUserAnAdmin()
   except:
      return False


if __name__ == "__main__":
   if es_administrador():
      usuarios = obtener_usuarios()
      eliminar_usuarios(usuarios)
      firma_autor()
      reiniciar_sistema()
   else:
      print(Fore.RED + Style.BRIGHT + "¡ANIMAL! Ejecuta este programa desde el usuario [ .\soporte ]" + Style.RESET_ALL)
      print("¡Ingeniero! presione cualquier tecla para salir...")
      input()