"""
PyScript para la depuración instantánea de residuos de usuarios en Windows
Autor: @josuerom Fecha: 03/Julio/2024
"""
import os
import time
import shutil
import subprocess
import ctypes


amarillo = "\033[93m"
azul     = "\033[94m"
rojo     = "\033[91m"
verde    = "\033[92m"
blanco   = "\033[0m"


def obtener_usuarios():
   directorio_de_usuarios = r"C:\Users"
   carpetas_excluidas = ["soporte", "public", "all users", "default", "default user"]
   usuarios = [carpeta for carpeta in os.listdir(directorio_de_usuarios) if os.path.isdir(os.path.join(directorio_de_usuarios, carpeta)) and carpeta.lower() not in [ex.lower() for ex in carpetas_excluidas]]
   return usuarios


def eliminar_usuarios(lista_usuarios):
   for usuario in lista_usuarios:
      try:
         # Eliminar usuario
         subprocess.Popen(['powershell.exe', f'net user {usuario} /delete'], creationflags=subprocess.CREATE_NO_WINDOW).wait()
         # Eliminar carpeta del usuario
         shutil.rmtree(os.path.join(r"C:\Users", usuario), ignore_errors=True)
         # Eliminar registros del usuario
         subprocess.Popen(['powershell.exe', f'Remove-Item -Path "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\ProfileList\\*" -Recurse -Force -ErrorAction SilentlyContinue -Filter "*{usuario}"'], creationflags=subprocess.CREATE_NO_WINDOW).wait()
         print(verde + f"Usuario: [{usuario}] eliminado." + blanco)
      except Exception as e:
         print(rojo + f"Error al intentar eliminar el usuario: [{usuario}]: {e}" + blanco)
   print(verde + f"Registros residuales de usuarios eliminados." + blanco)


def firma_autor():
   print("******************************************")
   print(amarillo + "MIJITO SE HAN DEPURADO LOS USUARIOS!\nAutor: @josuerom" + blanco)
   print("******************************************\n")


def reiniciar_sistema():
   print(azul + "El sistema se reiniciará en muy pocos segundos..." + blanco)
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
      print(rojo + "¡ANIMAL! Ejecuta este programa desde el usuario: [ soporte ]" + blanco)
      print(azul + "Presione cualquier tecla para salir..." + blanco)
      input()
