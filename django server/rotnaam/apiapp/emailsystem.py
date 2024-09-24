#################ส่งเมลล์ภาษาไทย########################
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText


def sendthai(sendto, subj="service@rotnaam.com", detail="สวัสดี!\nคุณสบายดีไหม?\n"):

    myemail = '6320610006@psu.ac.th'
    mypassword = "---------"
    receiver = sendto
    # myemail = 'rotnaamcontact@gmail.com'
    # mypassword = "rotnaamcompany"
    # receiver = sendto
    msg = MIMEMultipart('alternative')
    msg['Subject'] = subj
    msg['From'] = 'ROTNAAM COMPANY'
    msg['To'] = receiver
    text = detail

    part1 = MIMEText(text, 'plain')
    msg.attach(part1)

    s = smtplib.SMTP('smtp.gmail.com:587')
    s.ehlo()
    s.starttls()

    s.login(myemail, mypassword)
    s.sendmail(myemail, receiver.split(','), msg.as_string())
    s.quit()
    print('ส่งเเล้ว')

# title = "hi"
# msg ="""สวัสดีค่ะ/ครับ
#         ตอนนี้ทางเราได้รับเรียบร้อยเเล้ว
#         เเอดมินจะตอบกลับภายใน 24 ชั่วโมง"""
# sendthai("6320610006@psu.ac.th", title , msg )