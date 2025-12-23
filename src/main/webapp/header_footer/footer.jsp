<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer class="footer-section">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="footer-logo mb-3">
                    <h3 class="text-white fw-bold"><i class='bx bxs-dog'></i> Animal Doctors</h3>
                    <span class="text-white-50">International</span>
                </div>
                <p class="text-white-50 mb-2">Subscribe to our Newsletter</p>
                <form class="subscribe-form d-flex mb-3">
                    <input type="email" class="form-control me-1" placeholder="Your E-mail">
                    <button type="submit" class="btn btn-danger"><i class='bx bx-right-arrow-alt'></i></button>
                </form>
                <div class="social-icons">
                    <a href="#"><i class='bx bxl-facebook'></i></a>
                    <a href="#"><i class='bx bxl-instagram'></i></a>
                    <a href="#"><i class='bx bxl-linkedin'></i></a>
                </div>
            </div>

            <div class="col-lg-2 col-md-6 mb-4">
                <h5 class="text-white mb-3">Our Services</h5>
                <ul class="list-unstyled footer-links">
                    <li><a href="#">Clinical Services</a></li>
                    <li><a href="#">Surgery</a></li>
                    <li><a href="#">Holistic Therapy</a></li>
                    <li><a href="#">Cat Hotel</a></li>
                    <li><a href="#">Grooming</a></li>
                </ul>
            </div>

            <div class="col-lg-2 col-md-6 mb-4">
                <h5 class="text-white mb-3">About Us</h5>
                <ul class="list-unstyled footer-links">
                    <li><a href="#">Locations</a></li>
                    <li><a href="#">Careers</a></li>
                    <li><a href="#">VIPet membership</a></li>
                    <li><a href="#">Cookies</a></li>
                    <li><a href="#">Policies</a></li>
                </ul>
            </div>

            <div class="col-lg-5 col-md-6 mb-4">
                <h5 class="text-white mb-3">VIET NAM <span class="float-end">-</span></h5>
                <ul class="list-unstyled text-white-50 contact-info">
                    <li class="mb-2"><strong class="text-white">Hotline:</strong> 1900 633093</li>
                    <li class="mb-2"><strong class="text-white">International Call:</strong> +84 (0)28 7304 1144</li>
                    <li class="mb-2"><strong class="text-white">Email:</strong> info@animaldoctors.vn</li>
                    <li class="mb-2">
                        <strong class="text-white">Nguyen Van Huong Branch:</strong><br>
                        224-226 Nguyen Van Huong, Thao Dien, Thu Duc, HCMC
                    </li>
                    <li class="mb-2">
                        <strong class="text-white">Tay Ho Branch:</strong><br>
                        78 To Ngoc Van, Tay Ho, Hanoi
                    </li>
                    <li class="mt-3 text-white">
                        <strong>Opening hours:</strong> 9 am - 7 pm (7 days)<br>
                        24/7 emergency and critical care
                    </li>
                </ul>
            </div>
        </div>
    </div>
    
    <div class="footer-bottom text-center py-3">
        <p class="text-white-50 m-0">&copy; 2025 Animal Doctors International. All Rights Reserved.</p>
    </div>
</footer>

<style>
    .footer-section {
        background-color: #0b1a33; /* Màu xanh đậm giống ảnh */
        color: #fff;
        padding-top: 60px;
        font-size: 14px;
    }

    .subscribe-form .form-control {
        border-radius: 0;
        border: none;
    }

    .subscribe-form .btn {
        border-radius: 0;
        background-color: #8b0000; /* Màu đỏ đậm nút gửi */
        border: none;
    }

    .social-icons a {
        color: #fff;
        font-size: 24px;
        margin-right: 15px;
        text-decoration: none;
    }

    .footer-links li {
        margin-bottom: 10px;
    }

    .footer-links a {
        color: #b0b0b0;
        text-decoration: none;
        transition: 0.3s;
    }

    .footer-links a:hover {
        color: #fff;
        padding-left: 5px;
    }

    .contact-info li {
        line-height: 1.6;
    }

    .footer-bottom {
        border-top: 1px solid rgba(255,255,255,0.1);
        background-color: #081426;
    }
</style>