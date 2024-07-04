"""
PyScript para la depuración instantánea de residuos de usuarios en Windows
Autor: @josuerom Fecha: 03/Julio/2024
"""
import os
import time
import shutil
import subprocess
import ctypes


amarrillo = 0x06
azul = 0x09
rojo = 0x0C
verde = 0x0A
blanco = 0x07

def set_color(color):
   ctypes.windll.kernel32.SetConsoleTextAttribute(ctypes.windll.kernel32.GetStdHandle(-11), color)


def obtener_usuarios():
   directorio_de_usuarios = r"C:\Users"
   carpetas_excluidas = ["soporte", "public", "all users", "default", "default user"]
   usuarios = [carpeta for carpeta in os.listdir(directorio_de_usuarios) if os.path.isdir(os.path.join(directorio_de_usuarios, carpeta)) and carpeta.lower() not in [ex.lower() for ex in carpetas_excluidas]]
   return usuarios


def eliminar_usuarios(lista_usuarios):
   for usuario in lista_usuarios:
      try:
         subprocess.Popen(['powershell.exe', f'net user {usuario} /delete'], creationflags=subprocess.CREATE_NO_WINDOW).wait()
         shutil.rmtree(os.path.join(r"C:\Users", usuario), ignore_errors=True)
         subprocess.Popen(['powershell.exe', f'Remove-Item -Path "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\ProfileList\\*" -Recurse -Force -ErrorAction SilentlyContinue -Filter "*{usuario}"'], creationflags=subprocess.CREATE_NO_WINDOW).wait()
         set_color(verde)
         print(f"Usuario [{usuario}] eliminado.")
      except Exception as e:
         set_color(rojo)
         print(f"Error al intentar eliminar el usuario [{usuario}]:\n{e}")
         set_color(blanco)
         return
   set_color(verde)
   set_color(blanco)
   print(f"REGISTROS RESIDUALES DE USUARIO ELIMINADOS.")


def firma_autor():
   print("******************************************")
   set_color(amarrillo)
   print("MIJITO SE HAN DEPURADO LOS USUARIOS!\n\nAUTOR: @josuerom")
   set_color(blanco)
   print("******************************************\n")


def reiniciar_sistema():
   set_color(azul)
   print("El sistema se reiniciará en muy pocos segundos...")
   set_color(blanco)
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
      set_color(rojo)
      print("¡ANIMAL! Ejecuta este programa desde el usuario: [ .\\soporte ]")
      set_color(azul)
      print("Presione cualquier tecla para salir...")
      set_color(blanco)
      input()
