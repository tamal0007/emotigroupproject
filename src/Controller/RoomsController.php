<?php

namespace App\Controller;

use App\Entity\Rooms;
use App\Form\RoomsType;
use App\Repository\RoomsRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/rooms")
 */
class RoomsController extends AbstractController
{
    /**
     * @Route("/", name="rooms_index", methods={"GET"})
     */
    public function index(RoomsRepository $roomsRepository): Response
    {
        $title = "Manage Vacancies";
        return $this->render('rooms/index.html.twig', [
            'rooms' => $roomsRepository->findAll(),'title'=>$title,
        ]);
    }

    /**
     * @Route("/new", name="rooms_new", methods={"GET","POST"})
     */
    public function new(Request $request): Response
    {
        $room = new Rooms();
        $form = $this->createForm(RoomsType::class, $room);
        $form->handleRequest($request);
        $title = "Add New Vacancy";

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($room);
            $entityManager->flush();

            return $this->redirectToRoute('rooms_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('rooms/new.html.twig', [
            'room' => $room,
            'form' => $form,'title'=>$title,
        ]);
    }

    /**
     * @Route("/{id}", name="rooms_show", methods={"GET"})
     */
    public function show(Rooms $room): Response
    {
        $title = "Show Vacancies";
        return $this->render('rooms/show.html.twig', [
            'room' => $room,'title'=>$title,
        ]);
    }

    /**
     * @Route("/{id}/edit", name="rooms_edit", methods={"GET","POST"})
     */
    public function edit(Request $request, Rooms $room): Response
    {
        $title = "Edit Vacancies";
        $form = $this->createForm(RoomsType::class, $room);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $this->getDoctrine()->getManager()->flush();

            return $this->redirectToRoute('rooms_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('rooms/edit.html.twig', [
            'room' => $room,
            'form' => $form,'title'=>$title,
        ]);
    }

    /**
     * @Route("/{id}", name="rooms_delete", methods={"POST"})
     */
    public function delete(Request $request, Rooms $room): Response
    {
        
        if ($this->isCsrfTokenValid('delete'.$room->getId(), $request->request->get('_token'))) {
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->remove($room);
            $entityManager->flush();
        }

        return $this->redirectToRoute('rooms_index', [], Response::HTTP_SEE_OTHER);
    }
}
